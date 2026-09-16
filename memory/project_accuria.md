---
name: project-accuria
description: Accuria Debt Pricing Tool — R Shiny NPL pricing app; Matteo is building a Levered Returns tab and HTML export feature
metadata: 
  node_type: memory
  type: project
  originSessionId: 36937dfb-f100-469a-98c5-0346a03e8244
---

**Project:** Debt Portfolio Pricing Tool (R Shiny app) at Accuria.
**Working directory:** `~\OneDrive\Accuria\DebtPricingTool\DebtPricingTool`

**Goal:** Build a new "Levered Returns" tab in `app.R`.

Key inputs: senior advance rate, mezz advance rate, senior interest rate, mezz interest rate, waterfall structure, loan maturity, arrangement fee. Loan amounts calculated automatically as advance rate × purchase price.

Key outputs: equity IRR, equity MoM, comparison with unlevered returns, levered sensitivity grid.

**Why:** Leverage module (`calc_leverage.R`) and run-observer logic are already fully implemented and tested. The backend calculates everything — it just isn't shown in the UI yet.

**Final deliverable:** HTML export of the Leverage tab so it can be shared without R/RStudio.

**How:** Incremental steps — one tab, one section at a time. Test in RStudio after each step.
