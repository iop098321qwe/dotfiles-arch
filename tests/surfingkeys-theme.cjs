"use strict";

const assert = require("node:assert/strict");
const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const { test } = require("node:test");
const { execFileSync, spawnSync } = require("node:child_process");
const { pathToFileURL } = require("node:url");
const vm = require("node:vm");
const { parsePalette, publish } = require(
  "../dot_config/surfingkeys/omarchy-theme.cjs",
);

const keys = [
  "background", "foreground", "accent", "red", "green", "yellow",
  "blue", "cyan", "magenta", "selection_background", "selection_foreground",
];
const output = (mode = "dark") => [
  `mode\t${mode}`, ...keys.map((key) => `${key}\t#AbCdEf`),
].join("\n") + "\n";

test("accepts dark and light palettes and normalizes hex colors", () => {
  for (const mode of ["dark", "light"]) {
    const palette = parsePalette(output(mode) + "orange\t#123ABC\n");
    assert.equal(palette.version, 1);
    assert.equal(palette.mode, mode);
    assert.equal(palette.colors.background, "#abcdef");
    assert.equal(palette.colors.orange, "#123abc");
  }
  assert.equal(parsePalette(output()).colors.orange, undefined);
});

test("rejects incomplete palettes, invalid colors, and invalid modes", () => {
  for (const invalid of [
    "", output("invalid"), output().replace("#AbCdEf", "not-a-color"),
    output().replace("accent\t#AbCdEf\n", ""),
  ]) {
    assert.throws(() => parsePalette(invalid));
  }
});

test("publishes atomically, avoids unchanged writes, and replaces palettes", (t) => {
  const home = fs.mkdtempSync(path.join(os.tmpdir(), "surfingkeys-theme-"));
  t.after(() => fs.rmSync(home, { recursive: true, force: true }));
  const palette = parsePalette(output());
  const filename = publish(home, palette);
  assert.deepEqual(JSON.parse(fs.readFileSync(filename, "utf8")), palette);
  const before = fs.statSync(filename, { bigint: true });
  publish(home, palette);
  assert.equal(fs.statSync(filename, { bigint: true }).mtimeNs, before.mtimeNs);
  assert.equal(fs.statSync(filename, { bigint: true }).ino, before.ino);
  const light = parsePalette(output("light"));
  publish(home, light);
  assert.deepEqual(JSON.parse(fs.readFileSync(filename, "utf8")), light);
  assert.deepEqual(fs.readdirSync(path.dirname(filename)), ["omarchy-palette.json"]);
});

test("Chezmoi renders valid JavaScript and portable file URLs", () => {
  const template = path.join(__dirname,
    "../dot_config/surfingkeys/catppuccin-mocha-surfingkeys.js.tmpl");
  for (const home of ["/home/grymm", "/home/another user#?", '/home/quote"name']) {
    const rendered = execFileSync("chezmoi", [
      "--config", "/dev/null", "--config-format", "toml",
      "--override-data", JSON.stringify({ chezmoi: { homeDir: home } }),
      "execute-template", "--file", template,
    ], { encoding: "utf8" });
    new vm.Script(rendered);
    const options = rendered.split("const omarchyThemeOptions = Object.freeze(")[1]
      .split(");")[0];
    const actual = vm.runInNewContext(`(${options}).paletteUrl`);
    assert.equal(actual,
      pathToFileURL(path.join(home, ".config/surfingkeys/omarchy-palette.json")).href);
  }
});

test("apply and theme hooks initialize and refresh only isolated runtime data", (t) => {
  const home = fs.mkdtempSync(path.join(os.tmpdir(), "surfingkeys-hook-"));
  t.after(() => fs.rmSync(home, { recursive: true, force: true }));
  const root = path.join(__dirname, "..");
  const directory = path.join(home, ".config/surfingkeys");
  const hooks = path.join(home, ".config/omarchy/hooks/theme-set.d");
  const bin = path.join(home, "omarchy/bin");
  for (const dir of [directory, hooks, bin]) fs.mkdirSync(dir, { recursive: true });
  fs.copyFileSync(path.join(root, "dot_config/surfingkeys/omarchy-theme.cjs"),
    path.join(directory, "omarchy-theme.cjs"));
  const hook = path.join(hooks, "40-surfingkeys.sh");
  fs.copyFileSync(path.join(root,
    "dot_config/omarchy/hooks/theme-set.d/executable_40-surfingkeys.sh"), hook);
  fs.writeFileSync(path.join(bin, "omarchy-theme-color"),
    '#!/usr/bin/env bash\ncat "$HOME/palette.tsv"\n', { mode: 0o755 });
  fs.writeFileSync(path.join(bin, "omarchy"), "#!/bin/sh\nexit 0\n", { mode: 0o755 });
  const env = { ...process.env, HOME: home, OMARCHY_PATH: path.dirname(bin),
    XDG_STATE_HOME: path.join(home, "state"), PATH: `${bin}:/usr/bin` };
  const apply = path.join(root, ".chezmoiscripts/run_after_004_surfingkeys_theme.sh");
  fs.writeFileSync(path.join(home, "palette.tsv"), output());
  execFileSync("bash", [apply], { env });
  const palette = path.join(directory, "omarchy-palette.json");
  assert.equal(JSON.parse(fs.readFileSync(palette)).mode, "dark");
  fs.writeFileSync(path.join(home, "palette.tsv"), output("light"));
  execFileSync("bash", [hook, "test-light"], { env });
  assert.equal(JSON.parse(fs.readFileSync(palette)).mode, "light");
  const log = path.join(env.XDG_STATE_HOME, "omarchy/surfingkeys-theme.log");
  assert.match(fs.readFileSync(log, "utf8"), /Published palette for test-light/);
  fs.writeFileSync(path.join(home, "palette.tsv"), "invalid\n");
  assert.notEqual(spawnSync("bash", [hook], { env }).status, 0);
  assert.equal(JSON.parse(fs.readFileSync(palette)).mode, "light");
  assert.match(fs.readFileSync(log, "utf8"), /complete hex color palette/);
});
