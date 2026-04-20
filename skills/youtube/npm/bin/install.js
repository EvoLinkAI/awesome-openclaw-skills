#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const SLUG = "youtube-assistant";
const VERSION = "1.0.0";
const SKILL_FILES_DIR = path.join(__dirname, "..", "skill-files");

function findWorkdir() {
  const envDir = process.env.CLAWHUB_WORKDIR?.trim() || process.env.CLAWDHUB_WORKDIR?.trim();
  if (envDir) return path.resolve(envDir);

  let dir = process.cwd();
  while (true) {
    if (fs.existsSync(path.join(dir, ".clawhub")) || fs.existsSync(path.join(dir, ".clawdhub"))) {
      return dir;
    }
    const parent = path.dirname(dir);
    if (parent === dir) break;
    dir = parent;
  }
  return process.cwd();
}

function copyDirSync(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) copyDirSync(srcPath, destPath);
    else fs.copyFileSync(srcPath, destPath);
  }
}

function updateLockfile(workdir) {
  const lockDir = path.join(workdir, ".clawhub");
  const lockFile = path.join(lockDir, "lock.json");
  fs.mkdirSync(lockDir, { recursive: true });

  let lock = { skills: {} };
  if (fs.existsSync(lockFile)) {
    try { lock = JSON.parse(fs.readFileSync(lockFile, "utf8")); if (!lock.skills) lock.skills = {}; }
    catch { lock = { skills: {} }; }
  }

  lock.skills[SLUG] = { version: VERSION, installedAt: Date.now() };
  fs.writeFileSync(lockFile, JSON.stringify(lock, null, 2) + "\n");
}

function writeOrigin(targetDir) {
  fs.writeFileSync(path.join(targetDir, ".clawhub-origin.json"),
    JSON.stringify({ version: 1, registry: "https://api.clawhub.ai", slug: SLUG, installedVersion: VERSION, installedAt: Date.now() }, null, 2) + "\n");
}

function main() {
  console.log(`\n  YouTube Assistant — OpenClaw Skill Installer v${VERSION}`);
  console.log(`  Powered by evolink.ai\n`);

  const workdir = findWorkdir();
  const targetDir = path.join(workdir, "skills", SLUG);

  if (fs.existsSync(targetDir)) {
    console.log(`  Already installed at: ${targetDir}`);
    console.log(`  Use "npx clawhub update ${SLUG}" to update.\n`);
    process.exit(0);
  }

  console.log(`  Installing to: ${targetDir}`);
  copyDirSync(SKILL_FILES_DIR, targetDir);
  writeOrigin(targetDir);
  updateLockfile(workdir);
  console.log(`  Installed ${SLUG}@${VERSION}\n`);

  console.log("  Next steps:");
  console.log("  1. Install yt-dlp: pip install yt-dlp");
  console.log("  2. (Optional) export EVOLINK_API_KEY=\"your-key-here\"");
  console.log("  3. Run: bash scripts/youtube.sh help");
  console.log("");
}

main();
