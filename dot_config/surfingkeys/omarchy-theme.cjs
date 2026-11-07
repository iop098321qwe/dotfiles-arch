#!/usr/bin/env node
"use strict";

const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const { execFileSync } = require("node:child_process");

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

function atomicWrite(filename, contents) {
  const temporary = `${filename}.${process.pid}.tmp`;
  try {
    fs.writeFileSync(temporary, contents, { mode: 0o644, flag: "wx" });
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

// Chezmoi owns the scripts and browser configuration; only publish runtime data.
function publish(home = os.homedir(), palette = readPalette()) {
  const directory = path.join(home, ".config", "surfingkeys");
  fs.mkdirSync(directory, { recursive: true });
  const filename = path.join(directory, "omarchy-palette.json");
  const contents = JSON.stringify(palette, null, 2) + "\n";
  const existing = fs.existsSync(filename)
    ? fs.readFileSync(filename, "utf8") : null;
  if (existing !== contents) atomicWrite(filename, contents);
  return filename;
}

if (require.main === module) {
  try {
    if (process.argv[2] !== "publish") {
      throw new Error("Usage: node omarchy-theme.cjs publish");
    }
    console.log(publish());
  } catch (error) {
    console.error(`Surfingkeys Omarchy: ${error.message}`);
    process.exitCode = 1;
  }
}

module.exports = { parsePalette, atomicWrite, publish };
