#!/usr/bin/env node
// brain — Claude Code SessionStart nudge
//
// Claude Code plugins can't declare `statusLine` in plugin.json directly —
// it only lives in the user's own settings.json. So, same as caveman/
// ponytail: one-shot check on session start, and if no statusLine is
// configured yet, tell the model to offer setting one up. Never writes
// settings.json itself. Silent-fails on every error — never blocks session
// start over statusline detection.

const fs = require('fs');
const path = require('path');
const os = require('os');

const claudeDir = process.env.CLAUDE_CONFIG_DIR || path.join(os.homedir(), '.claude');
const settingsPath = path.join(claudeDir, 'settings.json');
const nudgeMarkerPath = path.join(claudeDir, '.brain-nudge-shown');

try {
  let hasStatusline = false;
  if (fs.existsSync(settingsPath)) {
    const settings = JSON.parse(fs.readFileSync(settingsPath, 'utf8'));
    if (settings.statusLine) hasStatusline = true;
  }

  // Refuse to write through a symlinked marker path — don't clobber
  // whatever it actually points at.
  const markerIsSymlink = fs.existsSync(nudgeMarkerPath) && fs.lstatSync(nudgeMarkerPath).isSymbolicLink();

  if (!hasStatusline && !fs.existsSync(nudgeMarkerPath) && !markerIsSymlink) {
    fs.writeFileSync(nudgeMarkerPath, '1');

    const isWindows = process.platform === 'win32';
    const scriptName = isWindows ? 'brain-statusline.ps1' : 'brain-statusline.sh';
    const scriptPath = path.join(__dirname, scriptName);
    const command = isWindows
      ? `powershell -ExecutionPolicy Bypass -File "${scriptPath}"`
      : `bash "${scriptPath}"`;
    const statusLineSnippet =
      '"statusLine": { "type": "command", "command": ' + JSON.stringify(command) + ' }';

    process.stdout.write(
      'STATUSLINE SETUP NEEDED: The brain plugin includes a statusline badge ' +
      '([BRAIN], plus a real project count once the wiki has any projects). ' +
      'It is not configured yet. To enable, add this to ' +
      path.join(claudeDir, 'settings.json') + ': ' + statusLineSnippet + ' ' +
      'Proactively offer to set this up for the user on first interaction.'
    );
  }
} catch (e) {
  // Silent fail — never block session start over statusline detection.
}
