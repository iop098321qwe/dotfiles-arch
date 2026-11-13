#!/usr/bin/env node
"use strict";

const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const { pathToFileURL } = require("node:url");
const { execFileSync } = require("node:child_process");

const configName = "catppuccin-mocha-surfingkeys.js";
const requiredColors = [
  "background", "foreground", "accent", "red", "green", "yellow",
  "blue", "cyan", "magenta", "selection_background", "selection_foreground",
];

function parsePalette(output) {
  const entries = Object.fromEntries(output.trim().split("\n")
    .map((line) => line.split("\t")));
  if (!["dark", "light"].includes(entries.mode) ||
      requiredColors.some((key) => !/^#[\da-f]{6}$/i.test(entries[key]))) {
    throw new Error("Omarchy did not provide a complete hex color palette");
  }
  const colors = Object.fromEntries([...requiredColors, "orange"]
    .filter((key) => /^#[\da-f]{6}$/i.test(entries[key]))
    .map((key) => [key, entries[key].toLowerCase()]));
  return { version: 1, mode: entries.mode, colors };
}

function atomicWrite(filename, contents, mode = 0o644) {
  const temporary = `${filename}.${process.pid}.tmp`;
  try {
    fs.writeFileSync(temporary, contents, { mode, flag: "wx" });
    fs.renameSync(temporary, filename);
  } finally {
    fs.rmSync(temporary, { force: true });
  }
}

function readPalette() {
  return parsePalette(execFileSync("omarchy-theme-color", ["--all"], {
    encoding: "utf8",
    timeout: 5000,
  }));
}

function publish(home = os.homedir(), palette = readPalette()) {
  const directory = path.join(home, ".config", "surfingkeys");
  fs.mkdirSync(directory, { recursive: true });
  const filename = path.join(directory, "omarchy-palette.json");
  const contents = JSON.stringify(palette, null, 2) + "\n";
  const existing = fs.existsSync(filename)
    ? fs.readFileSync(filename, "utf8") : null;
  if (existing !== contents) {
    atomicWrite(filename, contents);
  }
  return filename;
}

function install(
  home = os.homedir(), source = __dirname, palette = readPalette(),
) {
  // Resolve before replacing any working configuration.
  const directory = path.join(home, ".config", "surfingkeys");
  const hookDirectory = path.join(home, ".config", "omarchy", "hooks",
    "theme-set.d");
  const marker = "const omarchyThemeOptions = Object.freeze(" +
    "{ paletteUrl: null });";
  const original = fs.readFileSync(path.join(source, configName), "utf8");
  if (!original.includes(marker)) {
    throw new Error("Missing theme options marker");
  }
  const paletteUrl = pathToFileURL(path.join(directory,
    "omarchy-palette.json")).href;
  const options = JSON.stringify({ paletteUrl });
  const configured = original.replace(marker,
    `const omarchyThemeOptions = Object.freeze(${options});`);
  // Parse without executing browser code.
  new (require("node:vm").Script)(configured);
  fs.mkdirSync(directory, { recursive: true });
  fs.mkdirSync(hookDirectory, { recursive: true });
  const destination = path.join(directory, configName);
  if (fs.existsSync(destination)) {
    const backup = `${destination}.before-omarchy`;
    if (!fs.existsSync(backup)) fs.copyFileSync(destination, backup,
      fs.constants.COPYFILE_EXCL);
  }
  publish(home, palette);
  atomicWrite(path.join(directory, "omarchy-theme.cjs"),
    fs.readFileSync(path.join(source, "omarchy-theme.cjs")));
  atomicWrite(path.join(hookDirectory, "40-surfingkeys.sh"),
    fs.readFileSync(path.join(source, "omarchy-theme-set.sh")), 0o755);
  atomicWrite(destination, configured);
  return destination;
}

if (require.main === module) {
  try {
    if (process.argv[2] === "publish") console.log(publish());
    else if (process.argv[2] === "install") console.log(install());
    else throw new Error("Usage: node omarchy-theme.cjs <install|publish>");
  } catch (error) {
    console.error(`Surfingkeys Omarchy: ${error.message}`);
    process.exitCode = 1;
  }
}

module.exports = { parsePalette, atomicWrite, publish, install };
