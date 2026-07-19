#!/bin/bash
# Canned terminal session used by before.tape to render before.gif.
# Shows a verbose, hedgy answer to a plain question — the kind of response
# this plugin exists to prevent. No live session or API call — every line
# here is scripted output.

type_line() {
  local text="$1"
  local i
  for ((i = 0; i < ${#text}; i++)); do
    printf '%s' "${text:$i:1}"
    sleep 0.03
  done
  echo
}

# 1. Plain question, no slash command — how you'd normally ask Claude.
printf '%s' '❯ '
type_line 'Should I bump model to Opus or Fable for this?'
sleep 0.4

# 2. Verbose, hedgy answer. The terminal this renders in is only ~75 columns
# wide (FontSize 18 / Width 900 in before.tape), so raw long lines get
# hard-wrapped mid-word by the terminal. Pre-wrap with `fold -s` (breaks at
# spaces, never mid-word) to a width comfortably inside that column count.
ANSWER="That's a good question, and honestly it depends on a few factors. Opus tends to shine on tasks that need deep reasoning, nuanced judgment calls, or synthesizing information across multiple sources, so if this touches architectural decisions or ambiguous tradeoffs, the extra latency and cost could be worth it. Fable, by contrast, is generally the faster, more cost-efficient choice for work that's mostly mechanical or well-scoped, where the model just needs to follow clear instructions rather than reason from first principles. From what you've described — shell edits for a disk usage check, log rotation, and a staleness alert — none of that really calls for deep architectural reasoning; it's mostly pattern-matching against existing conventions. That said, if there's ambiguity in the alerting thresholds, or if this touches code with broader downstream effects, it might be worth erring toward the more capable model just to be safe. On balance, given the scope you've outlined, I'd lean toward saying this doesn't need the extra reasoning horsepower — but it's ultimately a judgment call."
printf '%s\n' "$ANSWER" | fold -s -w 72

# 3. Hold on the final frame before the loop.
sleep 2
