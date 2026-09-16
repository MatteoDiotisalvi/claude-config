---
name: project-trading-m4chronix
description: "New trading project investigating Instagram figure m4chronix's strategy for scam vs legitimacy before any real capital or automation"
metadata: 
  node_type: memory
  type: project
  originSessionId: 01fd8645-3cac-4bf4-a468-71db67aa8c88
  modified: 2026-09-15T20:14:49.074Z
---

Matteo started a project folder at `~\trading` (2026-09-15) to
investigate a trading strategy attributed to Instagram account "m4chronix,"
with the explicit goal of determining whether it is a scam or has a real
edge, before building any automated or semi-automated trading system.

**Why:** He wants to dedicate his only trading capital to this if it checks
out, and he has employment risk if trading goes wrong (see
`bloomberg-terminal-setup.ps1` / `desk_news.ps1` in his home directory,
suggesting a finance-adjacent job with likely compliance obligations
around personal trading). He explicitly asked to move slowly and
carefully, not rush to implementation.

**Resuming (saved 2026-09-15 at Matteo's request):** start by reading
`~\trading\00_START_HERE.md`, which gives current state, the
next step (Phase 1 latency logging in `13_backtest_plan.md`), the open
decisions, tool paths, and where raw data lives (`research_data\`: 53 reel
transcripts, video frames, literature search results). Verify files still
match that note before assuming anything.

**How to apply:** A full research plan (reviewed and polished, not yet
executed as of 2026-09-15) lives in the trading folder: `01_research_plan.md`
through `06_decision_framework.md`, plus `05_evidence_log_template.md` for
logging findings and `07_strategy_profile.md` / `08_verdict_memo.md` as
eventual research outputs. The plan requires paper trading before any real
capital, regardless of how credible the research makes the strategy look.
When resuming this project, read `README.md` in that folder first for
current status before assuming what stage the research is at. No code or
automation should be built until the decision gate in
`06_decision_framework.md` is explicitly cleared.

Known context from Matteo (2026-09-15): Phase 0 compliance is
self-assessed clear, no employer policy applies to him. He believes
m4chronix trades crypto, doesn't sell a course, and monetizes through a
discount code for a trading app rather than paid signals; this was
independently confirmed during research. Applies
[[feedback-thoroughness-over-speed]]: no time pressure on this,
prioritize getting it right.

**First-pass research result (2026-09-15):** verdict is do not follow or
copy-trade m4chronix (checklist score -7, see `08_verdict_memo.md` in the
trading folder). Not a classic custodial scam (his monetization is a Fomo
app referral code, not a paid course; Fomo itself is a real funded
company; Robinhood is a regulated broker) but also no verifiable track
record, an independent commenter claims his posted profits don't
reconcile with trackable activity, another accuses him of AI-faking a P&L
screenshot, and a structural leader/follower lag means anyone copying his
trades in real time buys at worse prices than he did (a follower
self-reported turning $100 into $15). On-chain wallet verification was attempted (2026-09-15): a third-party
tool (FomoScan) resolved his handle to a Solana wallet holding ~$136K,
but independent Solscan data showed 746,488 tiny transfers every 30-60
seconds from many unrelated addresses — looks like shared Fomo platform
infrastructure, not a clean personal wallet, so inconclusive on its own.
Bonus find: `fomoo.family` (double o) is a live wallet-draining phishing
clone of the real `fomo.family` — worth remembering if this space comes
up again.

**Second pass (2026-09-15, same day):** his real name is Damon Jennings
(stated on his own YouTube channel). He runs/is linked to multiple
Instagram accounts funneling the same referral code (m4chronix,
`damonjennings3.0` announced 6 Sept as a replacement, `povchronix`) —
confirmed in his own words that he restarted on a new account, which
previously was only a commenter's claim. A comment Instagram itself
auto-hid as "misleading" independently alleged the same ~$100K+ balance
discrepancy as before — now three independent sources on that same
number. Counterweight: a YouTube video shows a real loss narrated live
on camera, he explicitly warns followers about impersonators, and his
stated trader-selection methodology (7d vs 30d consistency, size vs.
gain, avoid the #1 leaderboard slot) is ordinary sound trading
psychology, not scammy. Score moved from -7 to -5.5 (see
`02_credibility_checklist.md`) — same "don't follow him" bucket, higher
confidence in the reasoning. Matteo clarified he wants inspiration, not
copy-trading, which lowers the real-time follower-lag risk but not the
"his specific numbers are unverified" problem.

**Third pass, same day:** Matteo asked for a real fix to the
video-watching limitation rather than a workaround. Solved it: installed
`yt-dlp` (Anaconda pip) + `ffmpeg` (winget, `Gyan.FFmpeg`, includes a
built-in Whisper filter) + a local Whisper model
(`ggml-base.en.bin`) — downloads videos directly and extracts
frames/transcripts locally, bypassing the browser-rendering problem
entirely. Documented in `09_video_analysis_method.md` in the trading
folder; reusable for future video-research tasks generally, not just
this project. TikTok, however, hit a hard login wall on every attempt
(profile page and direct video URL, both browser and yt-dlp) — not
bypassed, since logging in on his behalf is off the table; TikTok stays
unreviewed unless Matteo signs in himself.

Applying the fix immediately surfaced the biggest finding of the whole
investigation: a video captioned only "I owe you guys an explanation"
turned out to contain his actual explanation, in his own voice, for the
account restart — he says he pulled money from the trading balance and
bought a rental property (3-unit apartment complex + a house), citing a
bear market and an Instagram reach restriction, and states the balance
grew "from $60 to close to $200,000" before restarting the new series
with $2,000. Unverified (no property record or wallet checked), but
specific and falsifiable, and it lands in the same order of magnitude as
the independently-observed ~$100-136K balance rather than contradicting
it — changes the character of the uncertainty from "looks evasive" to "a
specific unproven story," without changing the recommendation. Separately,
a video frame showed his own app screen reading "$995.05 invested" on a
position he narrated as "$1,300" — probably ordinary slippage, not
deception, but a real mismatch worth knowing about if his numbers ever
get cited as precise.

**Fourth pass, same day:** Matteo asked to transcribe many reels and
follow the trades to check reported earnings, at scale. Downloaded and
transcribed ~53 reels from the "M4 to Ferrari SF90" series (the more
consistent of his two series). Every video restates the prior day's
ending balance before narrating that day's trade, so ~40 data points
across Day 9-67 (~2 months) could be cross-checked against each other.
Result: no contradiction found anywhere — every restated balance matches
what the prior video said, every trade's P&L arithmetically explains the
balance change. It also independently cross-validated against this
project's very first Instagram screenshot pass: a "Day 63" thumbnail
read "$144,248/$600,000," and today's audio-only reconciliation computed
Day 62's end at "$144,000" purely from arithmetic — two unrelated
methods landing on the same number. Full ledger in
`10_sf90_series_reconciliation.md`. Score moved -7 → -5.5 → -5 across the
three passes — not trending toward "credible," but toward
better-evidenced reasoning on both sides. This is real evidence against
the simplest kind of fabrication (making up whatever sounds good each
day) but still not third-party verification of anything — every number
traces back to him alone, and it's specific to the SF90 series, not the
separate, more troubled "1 SOL to a Lamborghini STO" series.
Recommendation unchanged throughout: don't follow or copy-trade him.

**Next stage, planned 2026-09-15 (not built):** Matteo wants to build his
own copy-trading strategy and backtest it over a couple of months using the
price available when a buy signal is confirmed on his side, after costs.
Researched academic literature (~50 verified papers), practitioner sources,
Reddit, and data APIs, then wrote `12_copytrading_research_review.md`,
`13_backtest_plan.md`, and `14_data_sources.md`. Core design: measure his
real notification-to-confirm latency first with zero money (Phase 1),
select leaders point-in-time from on-chain data before the test window,
simulate fills against pool reserves at the moment his order would land,
include every rugged/dead token, validate the simulator against real
copier wallets found on-chain, walk-forward test with a held-out month,
and a pre-registered pass bar (7 criteria incl. Deflated Sharpe, top-5%
trade removal, 1.5x costs, beating null models). Constraints found: Fomo's
terms require 18+ and prohibit bots/scrapers/automated data collection, so
all data comes from on-chain providers (Helius primary) and no automated
trading through Fomo. If Italian tax resident, crypto gains taxed 33% from
2026. Open decisions for Matteo are listed in section 11 of the plan.
