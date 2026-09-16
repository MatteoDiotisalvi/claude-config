---
name: reference-skill-suggester-hook
description: A UserPromptSubmit hook exists to catch missed skill invocations; where it lives and how it works
metadata: 
  node_type: memory
  type: reference
  originSessionId: e832c412-bb03-4899-b98a-7d45c6a136ec
  modified: 2026-09-14T16:28:40.978Z
---

Matteo asked (2026-09-14) for a systematic fix to skills sometimes not getting invoked when they should. Built as a `UserPromptSubmit` hook, not a prompting rule, since the point was to make the check mechanical rather than trust-based.

**Files:**
- `~/.claude/hooks/skill-suggester.ps1` — the matcher script. Reads the hook's JSON stdin payload, regex-matches the prompt against the trigger table, and on a hit emits `hookSpecificOutput.additionalContext` naming candidate skills. Fails safe: any error or no-match exits 0 with no output, never blocks the prompt. Logs matches to `~/.claude/hooks/skill-suggester.log`.
- `~/.claude/hooks/skill-triggers.json` — the trigger table (skill name → keywords/regex → reason), kept separate from the script so it can be tuned without touching logic. Covers the ~37 skills available as of 2026-09-14.
- Wired into `~/.claude/settings.json` under `hooks.UserPromptSubmit`.
- The handling rule (check each named skill, invoke or dismiss in one line, don't ignore the block) lives directly in `~/.claude/CLAUDE.md`, not duplicated here.

**Known gotcha already hit and fixed:** setting `[Console]::InputEncoding` on an already-redirected stdin in Windows PowerShell 5.1 injects a spurious BOM byte and breaks `ConvertFrom-Json`. The script deliberately does not set it, plus strips a stray BOM defensively as a second line of defense.

**How to apply going forward:** if a new skill gets added/removed, or a real skill match keeps getting missed by the hook, update `skill-triggers.json` rather than just noting the miss. If Matteo reports the reminders as too noisy or not firing, check `skill-suggester.log` first, it records every match (or `ERROR` line) with a timestamp and prompt preview.
