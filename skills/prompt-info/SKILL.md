---
name: prompt-info
description: Matteo is about to write a prompt by hand and wants a complete briefing first. Use when he invokes /prompt-info, or says things like "I'll write the prompt myself, what should I know", "brief me before I prompt", or "what's relevant for this prompt". Produces a sourced summary of context, decisions, preferences, constraints, gaps and defaults that could affect the prompt. Never starts the task and never drafts the prompt.
---

# Prompt info briefing

Matteo is about to write the prompt for a task himself. Your job is to hand him everything that could change how that prompt should be written, so nothing he needs is missing and nothing is left for me to guess later. You do not do the task, and you do not write the prompt or any prompt wording.

## Steps

1. **Identify the task.** Use the conversation and any text after the command. If it is genuinely unclear which task he means, ask one question with AskUserQuestion (2 to 4 options, most likely first). If there is little or no context yet, say so plainly and list only what you do know, rather than padding.
2. **Gather from what is already available.** Sources, in this order:
   - This conversation: requests, corrections, decisions, files read or edited, errors hit.
   - The memory index (`MEMORY.md` is already in context). Open a linked memory file only when its index line clearly bears on the task. Memory can be stale, so if a note names a file, path or tool, check it still exists (a quick read-only check) before relying on it, and say if it no longer does.
   - Project files that the task touches, only where a fact is needed and cannot be inferred. Read, never edit. Do not run web research unless a fact is essential and obtainable nowhere else.
   - CLAUDE.md and AGENTS.md rules that change what a good prompt must ask for.
3. **Check for gaps.** For each important fact, decide whether it is known, inferable or missing. Missing facts go under open questions, not guessed.
4. **Output one briefing** using the structure below. Drop any heading with nothing real to put under it.

## Briefing structure

- **Task as I understand it**: one or two sentences so he can correct me.
- **Relevant background**: project state, files, data, tools, versions, names. Include exact file paths.
- **Decisions already made**: settled choices the prompt should not reopen, and approaches he has rejected, with the reason if known.
- **His standing preferences that apply**: style and formatting rules, tone, language variety, how he wants things explained, working habits from memory or CLAUDE.md that change what the prompt should demand.
- **Constraints and risks**: permissions, tool or access limits, blocked sources, deadlines, things that must not be touched or reused, and ways this task has gone wrong before.
- **What I would assume if the prompt says nothing**: my default choices on scope, format, depth, whether to edit files or only advise, and whether to verify. Flag each default that might not be what he wants, so he can override it in the prompt.
- **Open questions and ambiguities**: points the prompt must pin down because I would otherwise guess. Say what each one affects.
- **Useful things to specify**: concrete details worth including (output format, length, audience, success criteria, what to verify, what to leave out, which skills or tools to use or avoid). Offer these as a checklist of topics, not finished wording.

## Rules

- Never use em dashes or en dashes. Use commas, full stops or parentheses.
- Cite the source of each fact in brief (this chat, a named file, a named memory note). Mark anything uncertain as uncertain. Never invent details to fill a gap.
- Do not draft the prompt, propose full prompt wording, or begin the task. If he then asks for a draft, treat that as a separate request.
- Be thorough but scannable: short bullets, no preamble, no closing summary, no repeated points across headings. Everything that could change the prompt belongs in, even if minor. Facts that cannot affect it do not.
- Plain language, British English. Gloss jargon only where it is genuinely non-obvious.
- Read-only. Make no edits, writes, commits or other changes while producing the briefing.
