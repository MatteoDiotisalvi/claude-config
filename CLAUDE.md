# Global working rules

These apply to every session, regardless of what project or folder is active.

- Never use em dashes or en dashes in any writing produced for Matteo, in files, artifacts, or chat replies. Use a comma, a period, or parentheses instead. He removes them by hand when he sees them, so don't introduce them.
- Check the auto memory system (`~/.claude/memory/MEMORY.md` and linked files, kept in its own private claude-memory repo, not the public claude-config repo) for standing context before assuming; it holds his role, ongoing projects, and prior feedback on how to work with him.
- A `UserPromptSubmit` hook (`~/.claude/hooks/skill-suggester.ps1`, keyword table in `~/.claude/hooks/skill-triggers.json`) scans every prompt for likely-relevant skills and injects a "[skill-suggester hook]" block into context when it finds a match. It's a blunt keyword match, not a judgment call, so when that block appears: check each named skill against the actual request and either invoke it via the Skill tool or say in one line why it doesn't apply, don't silently ignore the block. False positives are expected and fine to dismiss; the point is nothing gets missed silently. If a real skill match keeps getting missed by the hook, add its trigger phrase to `skill-triggers.json` rather than just noting it and moving on.

# Clarifying questions

- When clarification is genuinely needed (meaningful ambiguity, missing requirements, or an important decision), use the `AskUserQuestion` tool instead of writing the question as plain chat text.
- Ask one question per call, the most important unresolved one first. Wait for the answer, then decide whether another is needed.
- Offer 2 to 4 concise, context-specific options. Put a recommended option first and label it "(Recommended)" only when one clearly exists. The tool adds an "Other" row for typed answers by itself, so don't add one.
- Don't ask when the request is clear enough to proceed, for trivial details that context settles, or to approve actions that are already authorised.
- This only changes how questions are asked. Permission rules and approval requirements are unchanged.
- If the tool is unavailable (for example in a subagent or a non-interactive run), ask the single most important question in plain text instead.

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

# Token and context habits

- Use /clear between unrelated tasks (/rename first if you may resume). Prefer a fresh session over resuming a long idle one, since the cache expires after an hour.
- Pick the model and effort at the start of a task and keep them fixed. Don't add or remove MCP servers mid-task.
- Never trade quality for tokens: don't shorten answers, skip verification or lower effort on writing, research or analysis work.
- Delegate bulk reading, test output and web searches to a subagent that returns only findings. Skip subagents for small tasks, since each one re-reads its own context.
- Check /usage or /context when a session feels heavy.

# Compact instructions

- When compacting, keep the current goal, decisions made, files changed, open questions, and any quoted source text verbatim.
