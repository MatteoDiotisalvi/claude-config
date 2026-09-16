---
name: project-cross-device-laptop-setup
description: "Matteo uses Claude Code on a home laptop and a school laptop; cross-device resumability/config-parity setup and what's still pending"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1f1f98fd-082f-4ad8-8b9d-13824d03f8b6
  modified: 2026-09-16T16:42:49.696Z
---

Matteo works across two laptops (home and school) and wants sessions/config to feel like "one computer, two monitors" — not just kept in sync, but the same state viewed from either device.

**Decisions made:**
- Rejected Remote Control as the primary mechanism: it only exposes a *live* session on the originating machine, so it dies whenever the school laptop is off — a hard blocker for Matteo's actual usage pattern.
- Chose cloud sessions (`claude --cloud`, `claude --teleport`, claude.ai/code) as the primary surface for anything that should move between devices, since that state lives on Anthropic's VM, not on either laptop — genuinely single-state, multi-display.
- Chose git-based config sync ([[reference_claude_config_repo]]) as the source of truth for skills, `CLAUDE.md`, settings, hooks, and memory, extended into cloud sessions via a setup script (see below) rather than duplicating config per-project.
- On 2026-09-15 briefly made the config repo public to let a cloud-environment setup script `git clone` it with zero credential management (verified working at the time). Reverted to private on 2026-09-16 once the PC side wanted to sync personal memory notes into the same repo, see [[reference_claude_config_repo]] for the full reasoning. This broke the setup script's plain clone.

**Cloud environment setup script** (added at claude.ai/code, environment settings, Setup script field, on the "Default" environment): clones `claude-config` into `~/.claude` on every fresh VM before Claude Code launches. Currently broken as of 2026-09-16 since the repo went private, needs a scoped GitHub token added as an environment variable, not yet done. Also note the general caveat: even once fixed, it only reruns when the environment's cache expires (roughly 7 days) or the script/network settings are edited again, so a trivial re-save forces a refresh after updating a skill.

**Machine note:** all setup work (repo init/push, cloud environment setup script) happened on the school laptop's Claude Code session, confirmed 2026-09-16, not the home one as first assumed. The PC side (Matteo's other machine, referred to as "home laptop" earlier in setup and "PC" as of 2026-09-16, same machine) did its own merge into the repo separately and pushed first.

**Still pending (PC/home machine side, one-time, may already be resolved since the PC has apparently already merged and pushed its own config as of 2026-09-16):**
1. `claude /login` there with the same claude.ai account (needed for `--cloud`/`--teleport`), confirm with Matteo whether already done.
2. `git pull` there to receive whatever the school laptop pushes as part of today's merge.

**Still pending (school laptop / this machine):**
1. Fix the cloud-environment setup script: add a scoped, read-only GitHub personal access token as an environment variable so the private repo can still be cloned automatically into fresh cloud VMs.

**Memory limitation, resolved 2026-09-16:** the PC side added `"autoMemoryDirectory": "~/.claude/memory"` to `settings.json`, moving memory out of the old per-working-directory-hash location (`~/.claude/projects/<hash-of-cwd>/memory/`) into a single path that the config repo can actually sync. Takes effect after Claude Code is closed and reopened. The old per-project location still exists on this laptop with its own history and is not deleted, just superseded.
