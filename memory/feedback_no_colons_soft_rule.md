---
name: feedback-no-colons-soft-rule
description: "The \"no colons\" style preference for the trading-signal paper is a default to suggest, not a hard constraint — once the user deliberately adds a colon, don't flag it as an error again."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 2f31fde9-ea56-413f-8c10-e2c2d935f956
  modified: 2026-08-17T09:36:37.972Z
---

The paper's "avoid colon-led constructions" convention (e.g. "X is the following:", "one further filter: Y") originated as a descriptive observation, not a rule the user stated with a reason — after Data and Methodology were drafted, colons just hadn't appeared, so it got written down as the established style to keep matching for consistency.

**Why:** the user confirmed (2026-08-17) to keep offering this as the default guidance, but clarified that if they deliberately insert a colon during their own editing pass, that is a conscious choice, not a slip to correct.

**How to apply:** keep recommending colon-free phrasing when offering sentence options for this paper, same as before. But if a later doc re-fetch shows the user added a colon themselves, do not flag it as a mistake or suggest reverting it — treat it as settled, consistent with [[feedback_stop_reflagging_decided_edits]].
