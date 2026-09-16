---
name: feedback-stop-reflagging-decided-edits
description: "Once the user has decided on a suggested style/grammar/formatting edit, stop raising that specific item again, even if it stays unchanged in the document."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bfbd3722-bb3f-4aa7-b9b1-485ecb8ddccc
  modified: 2026-08-11T16:09:57.226Z
---

Once the user has responded to a suggested edit (fixed it, explicitly declined, or said to move on), do not bring that specific suggestion up again in later checks — even if a re-check of the document shows it's still unchanged.

**Why:** Said explicitly during sentence-by-sentence drafting of the Methodology section of [[matteo-diotisalvi-ai-trading-paper]] — repeated re-flagging of already-decided-on style points (a colon usage, a comma splice, a preposition, a word-choice like "sold" vs "shorted") was experienced as redundant and got in the way of moving forward with new content.

**How to apply:** Distinguish "new issue in newly-added text" (fine to flag) from "old issue I already raised and the user responded to" (do not re-raise). When doing a fresh full-section audit, only report genuinely new findings — don't re-list previously-surfaced-and-decided items as if they were new. This applies specifically once the user has actually weighed in on an item; items never yet raised are still fair game.
