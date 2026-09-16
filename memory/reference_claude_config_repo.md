---
name: reference-claude-config-repo
description: "Private GitHub repo syncing ~/.claude skills, CLAUDE.md, settings.json, hooks, and memory between Matteo's laptop and PC, and into cloud session VMs"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 1f1f98fd-082f-4ad8-8b9d-13824d03f8b6
  modified: 2026-09-16T00:00:00.000Z
---

Matteo's personal Claude Code config (skills, `CLAUDE.md`, `settings.json`, `hooks/`, `memory/`, `statusline-command.ps1`, `claude-notify.ps1`) is version controlled at `https://github.com/MatteoDiotisalvi/claude-config`. It uses an allowlist-style `.gitignore` in `~/.claude`, everything ignored by default, only the config subset un-ignored, so credentials, session transcripts (`projects/`), `history.jsonl`, and machine-specific `settings.local.json` never get committed.

**Visibility history:** briefly made public on 2026-09-15 so a cloud-session setup script could clone it with no login token, before the memory folder existed in the repo. Reverted to private on 2026-09-16 once syncing personal memory notes (financial/trading content included) became part of the plan, since those should never be publicly readable. Nothing sensitive was ever pushed while it was public, only skills and generic settings. Now that it is private again, the cloud-session setup script's plain unauthenticated `git clone` will fail; it needs a scoped GitHub token added as an environment variable on the cloud environment instead (not yet done as of 2026-09-16, see [[project_cross_device_laptop_setup]]).

Workflow: `git pull` in `~/.claude` at the start of a session, `git add -A && git commit && git push` after changing skills, config, hooks, or memory.
