---
name: reference-video-frame-extraction
description: "How to actually watch/transcribe a video (YouTube, Instagram, etc.) when browser automation screenshots won't render playing video"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 01fd8645-3cac-4bf4-a468-71db67aa8c88
  modified: 2026-09-15T20:14:45.759Z
---

Browser automation screenshots do not reliably show playing video content
on this machine — YouTube gets stuck on a loading spinner, Instagram
freezes on the static first frame. Confirmed while researching
[[project-trading-m4chronix]] (2026-09-15).

**Working fix:** download the video directly and process it locally,
bypassing the browser entirely.

- `yt-dlp` (installed via Anaconda's pip:
  `~\anaconda3\Scripts\pip.exe install yt-dlp`, runs from
  `~\anaconda3\Scripts\yt-dlp.exe`) downloads the actual
  video file from a YouTube or Instagram URL, no login needed for public
  content.
- `ffmpeg` (installed system-wide: `winget install --id Gyan.FFmpeg -e`,
  then available on PATH as `ffmpeg`/`ffprobe`) extracts a still frame at
  any timestamp (`ffmpeg -ss <time> -i video.mp4 -frames:v 1 out.jpg`),
  and can crop/upscale a small region for legibility
  (`-vf "crop=W:H:X:Y,scale=W2:H2"`).
- Extracted `.jpg` frames can then just be read directly (Claude has
  vision) — same as if the screenshot had worked in the first place.
- This specific ffmpeg build (Gyan.FFmpeg, full build) ships with a
  `whisper` audio filter (whisper.cpp) built in. The model is already
  saved permanently at `~\tools\whisper\ggml-base.en.bin`
  (originally from
  `https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin`,
  ~140MB). ffmpeg filter arguments dislike Windows drive-letter colons, so
  copy the model next to the video (or run from the model's folder) and
  pass just the file name. This transcribes any video's spoken audio locally:
  `ffmpeg -i video.mp4 -af "whisper=model=ggml-base.en.bin:language=en:format=text:destination=out.txt" -f null -`.
  Useful especially for Instagram/TikTok, which don't expose a transcript
  any other way (unlike YouTube, which has its own native transcript
  panel accessible without any of this).

**Known limitation:** TikTok refused to load at all without signing in —
profile pages and direct video URLs both hit a mandatory login wall,
through the browser and through `yt-dlp`. Do not log in or create an
account to get around this; it's a hard stop unless the user hands over
their own session.

**How to apply:** when a task needs to see inside a video (on-screen
text, exact numbers, what's actually shown vs. just said) and browser
screenshots aren't rendering it, reach for this pipeline instead of
declaring it impossible. It's already set up on this machine (the tools
are installed), so it's just a matter of running the commands. Save
downloaded video files to the session scratchpad, not the working
project directory, and copy only the specific findings into whatever
project file is tracking the research.
