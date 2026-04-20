#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const SLUG = "buddy-skill-creator";
const VERSION = "1.0.0";
const SKILL_FILES_DIR = path.join(__dirname, "..", "skill-files");

// --- Resolve workdir (same logic as clawhub CLI) ---

function findWorkdir() {
  const envDir =
    process.env.CLAWHUB_WORKDIR?.trim() ||
    process.env.CLAWDHUB_WORKDIR?.trim();
  if (envDir) return path.resolve(envDir);

  let dir = process.cwd();
  while (true) {
    if (
      fs.existsSync(path.join(dir, ".clawhub")) ||
      fs.existsSync(path.join(dir, ".clawdhub"))
    ) {
      return dir;
    }
    const parent = path.dirname(dir);
    if (parent === dir) break;
    dir = parent;
  }

  return process.cwd();
}

// --- Copy directory recursively ---

function copyDirSync(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// --- Update lock.json ---

function updateLockfile(workdir) {
  const lockDir = path.join(workdir, ".clawhub");
  const lockFile = path.join(lockDir, "lock.json");

  fs.mkdirSync(lockDir, { recursive: true });

  let lock = { skills: {} };
  if (fs.existsSync(lockFile)) {
    try {
      lock = JSON.parse(fs.readFileSync(lockFile, "utf8"));
      if (!lock.skills) lock.skills = {};
    } catch {
      lock = { skills: {} };
    }
  }

  lock.skills[SLUG] = {
    version: VERSION,
    installedAt: Date.now(),
  };

  fs.writeFileSync(lockFile, JSON.stringify(lock, null, 2) + "\n");
}

// --- Write .clawhub-origin.json ---

function writeOrigin(targetDir, registry) {
  const originFile = path.join(targetDir, ".clawhub-origin.json");
  const origin = {
    version: 1,
    registry: registry,
    slug: SLUG,
    installedVersion: VERSION,
    installedAt: Date.now(),
  };
  fs.writeFileSync(originFile, JSON.stringify(origin, null, 2) + "\n");
}

// --- Main ---

function main() {
  console.log(`\n  Buddy Skill Creator — OpenClaw Skill Installer v${VERSION}`);
  console.log(`  Powered by evolink.ai\n`);

  const workdir = findWorkdir();
  const skillsDir = path.join(workdir, "skills");
  const targetDir = path.join(skillsDir, SLUG);

  if (fs.existsSync(targetDir)) {
    console.log(`  ⚠  Already installed at: ${targetDir}`);
    console.log(`  Use "npx clawhub update ${SLUG}" to update, or delete the folder and re-run.\n`);
    process.exit(0);
  }

  console.log(`  Installing to: ${targetDir}`);
  copyDirSync(SKILL_FILES_DIR, targetDir);

  writeOrigin(targetDir, "https://api.clawhub.ai");
  updateLockfile(workdir);

  console.log(`  ✓  Installed ${SLUG}@${VERSION}\n`);

  console.log("  Next steps:");
  console.log("");
  console.log("  1. Set EvoLink API key (required for AI analysis):");
  console.log('     export EVOLINK_API_KEY="your-key-here"');
  console.log("     Get one free at: https://evolink.ai/signup");
  console.log("");
  console.log("  2. (Optional) Install Pillow for photo EXIF analysis:");
  console.log("     pip3 install Pillow");
  console.log("");
  console.log("  3. Start creating your buddy:");
  console.log("     /create-buddy");
  console.log("");
}

main();
