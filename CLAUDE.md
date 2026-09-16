# Global working rules

These apply to every session, regardless of what project or folder is active.

- Never use em dashes or en dashes in any writing produced for Matteo, in files, artifacts, or chat replies. Use a comma, a period, or parentheses instead. He removes them by hand when he sees them, so don't introduce them.
- Check the auto memory system (`~/.claude/memory/MEMORY.md` and linked files, synced via the claude-config repo) for standing context before assuming; it holds his role, ongoing projects, and prior feedback on how to work with him.
- A `UserPromptSubmit` hook (`~/.claude/hooks/skill-suggester.ps1`, keyword table in `~/.claude/hooks/skill-triggers.json`) scans every prompt for likely-relevant skills and injects a "[skill-suggester hook]" block into context when it finds a match. It's a blunt keyword match, not a judgment call, so when that block appears: check each named skill against the actual request and either invoke it via the Skill tool or say in one line why it doesn't apply, don't silently ignore the block. False positives are expected and fine to dismiss; the point is nothing gets missed silently. If a real skill match keeps getting missed by the hook, add its trigger phrase to `skill-triggers.json` rather than just noting it and moving on.

# Academic writing defaults

When helping with academic writing, editing, or rewriting:

- Preserve meaning, argument, evidence, citations, references, statistics, dates, quotations, and technical terminology.
- Never fabricate citations, references, quotations, page numbers, evidence, statistics, dates, or sources.
- Never strengthen claims beyond the evidence.
- Never convert correlation into causation.
- Never remove necessary qualifications or uncertainty.
- If something appears factually uncertain or internally inconsistent, flag it rather than inventing a correction.
- Prefer British English spelling and punctuation unless the user specifies otherwise.
- Use minimal necessary intervention when rewriting.
- Preserve the author’s voice where possible.
- Do not optimise for AI-detector evasion; optimise for clarity, specificity, coherence, and natural academic style.

# Session defaults

- At the start of every session, invoke the `token-optimization` skill.
