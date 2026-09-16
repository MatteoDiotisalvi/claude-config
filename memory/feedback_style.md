---
name: feedback-style
description: "Always match the existing app's visual style exactly — colours, font sizes, card layouts, CSS classes"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 36937dfb-f100-469a-98c5-0346a03e8244
---

Always match the existing app's coding and visual style exactly when adding new UI elements to the Accuria Debt Pricing Tool. This means:
- Use the same CSS classes already defined (e.g. `metric-card primary/secondary`, `card`, `card-title`, `chart-row`, `section-label`)
- Use the same colour variables (e.g. `var(--navy)`, `var(--color-border)`, `var(--color-text-secondary)`)
- Match font sizes (card labels: 11px, card values: larger, section labels: 9px uppercase)
- Match spacing/padding conventions used in other tabs
- Do NOT introduce inline styles that deviate from established patterns
- Do NOT add new CSS classes if an existing one already covers the need

**Why:** Matteo's boss expects a polished, consistent product. New sections should look native, not bolted on.
**How to apply:** Before writing any UI code, re-read the relevant existing tab (e.g. Deal Summary) and replicate its exact structure.
