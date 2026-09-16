---
name: feedback-calibrate-explanation-depth
description: "When drafting academic-paper sentences involving technical concepts, only add plain-language glosses for genuinely non-obvious concepts; simple concepts get normal college/publication register directly, no extra scaffolding."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bfbd3722-bb3f-4aa7-b9b1-485ecb8ddccc
  modified: 2026-08-12T08:54:19.660Z
---

Don't apply the same "gloss the jargon inline" treatment uniformly to every technical sentence. Judge each concept on its own: if a strong, top-achieving high-school-level reader could already understand it from the term itself (e.g., "the top 20% and bottom 20%," equal weighting), write it at normal college/publication level with no added explanation. If the concept is genuinely non-obvious even to a bright reader (e.g., multicollinearity, regularisation/Ridge shrinkage, heteroskedasticity-robust standard errors), keep the inline plain-language gloss approach established for [[matteo-diotisalvi-ai-trading-paper]]'s Methodology section.

**Why:** Said explicitly after a run of turns simplifying the Ridge/multicollinearity explanation — the user wants accessibility calibrated to actual concept difficulty, not applied as a blanket rule, since over-explaining simple ideas reads as padding/condescending in a publication-level paper.

**How to apply:** Before drafting sentence options for a technical claim, ask: would a strong high-schooler already get this from the term alone? If yes, skip the gloss and write straight college-level prose. If no, use the established pattern: name the technical term, but wrap it with a brief plain-language explanation of the underlying mechanism, in the same sentence or the one right after — same as was done for "multicollinearity" and "Ridge regression shrinks coefficients toward zero."
