#!/usr/bin/env node

'use strict';

const fs = require('node:fs');
const path = require('node:path');
const os = require('node:os');
const process = require('node:process');
const readline = require('node:readline/promises');

const SKILLS = ['1s', '1p'];

function parseArgs(argv) {
  const flags = { global: false, project: false, yes: false };
  for (const arg of argv) {
    switch (arg) {
      case '--global':
      case '-g':
        flags.global = true;
        break;
      case '--project':
      case '-p':
        flags.project = true;
        break;
      case '--yes':
      case '-y':
        flags.yes = true;
        break;
      default:
        // ignore unknown args
        break;
    }
  }
  return flags;
}

async function resolveTargetDir(flags) {
  if (flags.project) {
    return path.join(process.cwd(), '.claude', 'skills');
  }
  if (flags.global) {
    return path.join(os.homedir(), '.claude', 'skills');
  }
  if (flags.yes) {
    // --yes alone defaults to project.
    return path.join(process.cwd(), '.claude', 'skills');
  }

  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  try {
    const answer = (
      await rl.question(
        "Install onebreath skills to (1) this project's .claude/skills or (2) your global ~/.claude/skills? [1/2] "
      )
    ).trim();
    if (answer === '2' || answer.toLowerCase().startsWith('g')) {
      return path.join(os.homedir(), '.claude', 'skills');
    }
    return path.join(process.cwd(), '.claude', 'skills');
  } finally {
    rl.close();
  }
}

async function confirmOverwrite(skillName, targetPath) {
  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  try {
    const answer = (
      await rl.question(`onebreath/${skillName} is already installed at ${targetPath} — overwrite? (y/N) `)
    ).trim();
    return answer.toLowerCase() === 'y' || answer.toLowerCase() === 'yes';
  } finally {
    rl.close();
  }
}

async function main() {
  const flags = parseArgs(process.argv.slice(2));
  const targetDir = await resolveTargetDir(flags);

  fs.mkdirSync(targetDir, { recursive: true });

  const sourceSkillsDir = path.join(__dirname, '..', 'skills');
  const installed = [];

  for (const skillName of SKILLS) {
    const sourcePath = path.join(sourceSkillsDir, skillName);
    const targetPath = path.join(targetDir, skillName);

    if (fs.existsSync(targetPath)) {
      const overwrite = flags.yes ? true : await confirmOverwrite(skillName, targetPath);
      if (!overwrite) {
        console.log(`Skipping onebreath/${skillName} (already installed, not overwriting).`);
        continue;
      }
    }

    fs.cpSync(sourcePath, targetPath, { recursive: true });
    installed.push(skillName);
  }

  if (installed.length === 0) {
    console.log('\nNo skills were installed.');
    return;
  }

  console.log(
    `\nInstalled onebreath skill${installed.length > 1 ? 's' : ''} (${installed.join(', ')}) to ${targetDir}`
  );
  console.log('Use them in Claude Code via /1s and /1p.');
}

main().catch((err) => {
  console.error(err && err.stack ? err.stack : err);
  process.exitCode = 1;
});
