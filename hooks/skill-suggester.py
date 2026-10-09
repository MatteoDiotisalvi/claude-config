#!/usr/bin/env python3
"""UserPromptSubmit hook: match the incoming prompt against skill-triggers.json and,
on a hit, inject a reminder into Claude's context via hookSpecificOutput.additionalContext.

Same behaviour and log format as the older skill-suggester.ps1 (kept as a backup in
~/.claude/backups), but starts in about 0.1 s instead of 0.8 s.
Design goals: never block the prompt, never raise past this script.
"""
import json
import os
import re
import sys
from datetime import datetime

HERE = os.path.dirname(os.path.abspath(__file__))
TRIGGERS_PATH = os.path.join(HERE, "skill-triggers.json")
LOG_PATH = os.path.join(HERE, "skill-suggester.log")


def write_log(message):
    try:
        stamp = datetime.now().astimezone().isoformat()
        with open(LOG_PATH, "a", encoding="utf-8") as f:
            f.write("%s\t%s\n" % (stamp, message))
    except Exception:
        pass


def find_hits(prompt, triggers):
    lowered = prompt.lower()
    hits = []
    for skill, definition in triggers.items():
        for kw in definition.get("keywords", []):
            try:
                if re.search(kw, lowered, re.IGNORECASE):
                    hits.append((skill, definition.get("reason", "")))
                    break
            except re.error:
                continue
    return hits


def build_context(hits):
    lines = ["- %s: %s" % (skill, reason) for skill, reason in hits]
    return (
        "[skill-suggester hook] Keyword match against this prompt found candidate skill(s) below. "
        "Before answering, briefly confirm whether one genuinely applies (invoke it via the Skill tool) "
        "or state in one line why it does not. "
        "This is a mechanical keyword match, not a judgment, false positives are expected and fine to dismiss.\n"
        + "\n".join(lines)
    )


def main():
    try:
        raw = sys.stdin.buffer.read().decode("utf-8-sig")
        if not raw.strip():
            return
        prompt = json.loads(raw).get("prompt")
        if not prompt or not prompt.strip():
            return
        if not os.path.isfile(TRIGGERS_PATH):
            return
        with open(TRIGGERS_PATH, "r", encoding="utf-8-sig") as f:
            triggers = json.load(f)

        hits = find_hits(prompt, triggers)
        if not hits:
            return

        preview = re.sub(r"[\r\n\t]", " ", prompt[:100])
        write_log('MATCH prompt="%s" skills=%s' % (preview, ",".join(s for s, _ in hits)))

        result = {
            "hookSpecificOutput": {
                "hookEventName": "UserPromptSubmit",
                "additionalContext": build_context(hits),
            }
        }
        sys.stdout.buffer.write(json.dumps(result, ensure_ascii=False).encode("utf-8"))
    except Exception as e:
        write_log("ERROR %s" % e)


if __name__ == "__main__":
    main()
    sys.exit(0)
