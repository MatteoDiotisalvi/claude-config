---
name: ask-mentors
description: Answers a UCAS/university-admissions question for Matteo by consulting his curated admissions mentors and doing fresh, source-verified research on what each relevant one has actually said, plus a live search of the curated subreddits listed in the "Community sources" section of Virtual_Mentors.md (falling back to r/6thform, r/UniUK, r/IBO, TheStudentRoom when that section has no entries) for anything the mentors don't cover. Always use this skill when Matteo asks for advice, an opinion, or "what would X think" about his UCAS personal statement, university choice, application strategy, TARA prep, or the admissions process generally, for his Imperial/LSE/UCL/King's/Warwick Computer Science applications. Don't just answer from general knowledge or memory of the files, this skill exists precisely because he wants weighted, source-grounded advice pulled fresh each time, not a static answer. Triggers on phrases like "ask the mentors", "what do the mentors think", "check with X", "get advice on", "what would [named mentor] say", or any open-ended admissions-strategy question during this project.
---

# Ask Mentors: weighted, source-verified admissions advice

## Why this exists

Matteo built a curated research base at `~\OneDrive\School\Applications\` (`Virtual_Mentors.md`, `Exemplar Personal Statements\Index.md`, `IB_UK_Admissions_Notes.md`) over a long research project. That base is necessarily a snapshot, it can never capture everything a real person has actually said on every possible question. This skill's job is to treat that base as a starting point for *who's relevant*, then go find out what they'd actually say about *this specific question*, verified fresh each time, rather than just re-reading what's already written down.

## The one rule that matters most

**Never attribute a claim, opinion, or quote to a real named person unless you found an actual, verifiable source for it in this specific research pass** (a real link, a real quote, something you could hand to Matteo to check yourself). This matters because these are real people with real reputations, not fictional characters, putting invented words in their mouths, even words that sound plausible given their general stance, is a form of misinformation about a real person. If a subagent researching a given mentor can't find anything directly on-topic, the honest answer is "no directly attributable statement found from [name] on this specific question", not a plausible-sounding guess dressed up as their view.

It's still fine, and often useful, to reason from a mentor's *documented general philosophy* (already captured in `Virtual_Mentors.md`, e.g. "Richard Partington's stated focus is on what distinguishes strong applicants beyond polish") to suggest how they *might* approach the question. But this must be visually and textually labeled as an inference, never blended in as if it carried the same weight as a verified direct statement. See the output template below for exactly how to mark the difference.

## Procedure

### 0. Check whether the full pipeline is even needed

If Matteo's question is really a simple factual lookup that the curated files already answer directly (a deadline, a points requirement, a fee figure), just answer it from the file, citing where it's from. The full research pipeline below is for genuine advice/opinion questions ("should I...", "what do people think about...", "is it worth..."), where different real sources might actually disagree, not for retrieving a fact that's already settled. Running four research subagents to answer something already sitting in `Deadlines.md` wastes real time and money for no benefit.

### 1. Identify who's actually relevant

Read (or grep, if the files are long) `Virtual_Mentors.md`, `Exemplar Personal Statements\Index.md`, and `IB_UK_Admissions_Notes.md`. Pick the **3 to 5 most relevant named mentors or real-testimony sources** for this specific question, not every entry in the files. Judge relevance by matching the question's actual topic against what each mentor is documented as focusing on (e.g. Simon Clark and Richard Partington are STEM/general-admissions-craft voices, Ali Abdaal is specifically strong on personal-statement review reasoning, the Oxford Economics tutor AMA is the one to reach for on subject-motivation questions), not just picking the first few names in the file. A question about opening-line craft points toward different people than a question about firm/insurance strategy. If the question is broad enough that more than 5 are genuinely relevant, say so and ask Matteo whether he wants the full sweep or the top handful, rather than silently running an expensive query.

**Then, separately, pick the curated communities.** Read the "Community sources: subreddits" section at the end of `Virtual_Mentors.md`. Pick the **1 to 3 subreddits** whose "Good for" field fits the question and whose "Not good for" field doesn't rule it out. This is a separate count from the 3 to 5 mentors, subreddits never take a mentor's slot. If the section has no entries yet, use the default sweep (r/6thform, r/UniUK, r/IBO, TheStudentRoom). Subreddits are not people, so the sourcing rule above applies to them in adapted form: never attribute a view to "r/X" as a whole, only to specific threads and commenters, following the numbered rules in that section.

### 2. Fresh research per mentor, and a separate community scan, batched to avoid a known collision

For each mentor identified, spawn a subagent (the Agent tool, `general-purpose` type works well) with a task that:
- Names the specific real person/source and what's already known about them (their credential, platform, the existing entry in `Virtual_Mentors.md` if there is one) so the subagent isn't starting cold.
- States the specific question Matteo asked.
- Instructs it to do real web research (WebSearch/WebFetch for most sources) to find something this specific person has actually, verifiably said that bears on the question.
- States the sourcing rule above explicitly, and instructs the subagent to return "not found" rather than invent something if nothing turns up.
- Asks it to return: the verified quote/position with its source link if found, OR an explicit "nothing found" if not, OR (separately, clearly labeled) a documented-philosophy-based inference if that's the most useful thing available.

Separately, **one** subagent does the community scan from step 3 below, covering every subreddit picked in step 1, one after another, in a single browser session. Don't spawn one subagent per subreddit: they all need the browser tools, so parallel subreddit agents would hit the collision described next.

**Known collision, confirmed by an actual test run of this skill, not theoretical:** any subagent using the `mcp__claude-in-chrome__*` browser tools (needed for reddit.com, since WebFetch hard-blocks it, and sometimes useful for YouTube transcripts) shares one browser session with any other subagent doing the same thing at the same time. Running several of these concurrently caused a real tab collision in testing and cost one research thread its lead. **So: batch the mentor-research subagents (which mostly need only WebSearch/WebFetch, no browser tool) together in parallel as before, but run the community-scan subagent (which definitely needs the browser tools for Reddit) as a separate, sequential step, either just before or just after the mentor batch, not inside the same parallel launch.** If a specific mentor-research subagent turns out to need YouTube transcript access via the browser tools too, treat it like the community scan, run it on its own rather than alongside another browser-tool user.

### 3. What the community scan actually covers

Point it at the subreddits picked in step 1 (or the default sweep, including TheStudentRoom's live forum rather than just its curated library), using the Chrome browser route for Reddit (`mcp__claude-in-chrome__*`, never WebFetch, which hard-blocks reddit.com; say this outright in the prompt). The subagent prompt must include, for each curated subreddit, the entry's **"How to search it"**, **"Trust signals available"**, **"Known biases"** and **"Threads already cited"** fields copied in, so it searches the way that entry says works and skips threads already documented. It must also include, copied in word for word, the numbered rules from the "Rules the skill follows for every subreddit" block in `Virtual_Mentors.md`: thread-level attribution, agreement needing 3+ separate commenters, the three evidence tiers, the timing filter for statement-format questions, and the relevance filter restating Matteo's IB / CS / five-university profile. Don't summarise those rules, paste them, since a subagent only applies the context its instructions actively tell it to use.

Ask it to return, per subreddit: findings labelled by tier (**Flaired insider / Corroborated anecdote / Agreement across N commenters / Nothing found**), each with its thread link, commenter handle and date, plus any disagreement found. Same verification standard as the rest of this project: don't take a single unverified claim at face value, and don't pad with generic restated advice, only include something genuinely specific or differentiated.

**Keeping entries current.** If the scan notices that a curated entry's fields are clearly out of date (the subreddit has gone quiet, a flair system changed, a rule was added), mention it in the output as a suggested update. Don't edit `Virtual_Mentors.md` during an advice run.

### 4. Verify before you present

Don't just trust the self-reports. At minimum, independently re-check any single claim that will be presented as **Verified** with a quote, actually open the source link and confirm it says what the subagent claims. This project has already caught fabricated or mischaracterized claims in pasted third-party reports twice (see `feedback_verify_pasted_reports.md`) and unreliable AI-generated search summaries once during this skill's own test run, the same discipline applies here. If something looks off, either drop it or flag it as unverified rather than passing it through. If a subagent fails, times out, or returns something that doesn't fit "verified / inference / nothing found," treat that as its own "nothing found" rather than guessing what it might have meant.

### 5. Output format

Use this structure:

```
## What each mentor says

### [Mentor name]
**[Verified / Extrapolated from documented philosophy / Nothing found on this specific question]**
[The actual quote + source link, OR the inference clearly framed as such, OR a one-line note that nothing turned up]

(repeat per mentor)

## What the communities say

### r/[name]
**[Flaired insider / Corroborated anecdote / Agreement across N commenters / Nothing found on this specific question]**
[The finding, with thread link, commenter and date. For an agreement, how many separate commenters and any notable disagreement. Flag anything that only applies to A-level, US, or the old single-essay statement format.]

(repeat per subreddit searched)

## Weighing it up
[A synthesized recommendation. State which mentors' input carries more weight and why, using the same hierarchy Virtual_Mentors.md already established: independently verified beats self-declared, free/no-sales-agenda beats commercial-with-a-funnel, directly relevant to Matteo's actual situation (IB Diploma, Imperial/LSE/UCL/King's/Warwick, Computer Science, his curiosity throughline) beats generic advice. Community findings sit below any verified named mentor or official admissions voice, in the order flaired insider, then agreement across several commenters, then a single corroborated anecdote. Their real value is recency and what happened to applicants like Matteo, so lean on them for "what's happening this cycle" questions, not for overriding an admissions officer. Where mentors disagree, say so and explain which context each one's advice came from rather than picking a winner arbitrarily.]
```

Keep it readable, this is advice Matteo will actually act on, not a research dump. If the honest answer after all this is "the mentors don't really address this specific question," say that plainly rather than padding.
