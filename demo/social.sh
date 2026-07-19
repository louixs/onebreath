#!/bin/bash
# Canned terminal session used by social.tape to render social.gif (then
# converted to social.mp4). Combines before.sh (verbose, hedgy plain-Claude
# answer) and after.sh (the same question through /onebreath:1s) into one
# before/after contrast clip for platforms that can't render a two-column
# README table (X, LinkedIn, ...). No live session or API call — every line
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

# --- BEFORE: plain question, no slash command ---
printf '%s' '❯ '
type_line 'Should I bump model to Opus or Fable for this?'
sleep 0.4

# Verbose, hedgy answer. Terminal is ~75 columns wide (FontSize 18 / Width
# 900 in social.tape), so pre-wrap with `fold -s` (breaks at spaces, never
# mid-word) instead of letting raw long lines hard-wrap mid-word.
ANSWER="That's a good question, and honestly it depends on a few factors. Opus tends to shine on tasks that need deep reasoning, nuanced judgment calls, or synthesizing information across multiple sources, so if this touches architectural decisions or ambiguous tradeoffs, the extra latency and cost could be worth it. Fable, by contrast, is generally the faster, more cost-efficient choice for work that's mostly mechanical or well-scoped, where the model just needs to follow clear instructions rather than reason from first principles. From what you've described — shell edits for a disk usage check, log rotation, and a staleness alert — none of that really calls for deep architectural reasoning; it's mostly pattern-matching against existing conventions. That said, if there's ambiguity in the alerting thresholds, or if this touches code with broader downstream effects, it might be worth erring toward the more capable model just to be safe. On balance, given the scope you've outlined, I'd lean toward saying this doesn't need the extra reasoning horsepower — but it's ultimately a judgment call."
printf '%s\n' "$ANSWER" | fold -s -w 72

# Hold on the verbose answer so the contrast lands before the cut.
sleep 2

# --- TRANSITION: brief label frame, then wipe ---
clear
sleep 0.2
echo "same question, via /onebreath:1s"
sleep 1
clear

# --- AFTER: same question, run as a slash command ---
printf '%s' '❯ '
type_line '/onebreath:1s Should I bump model to Opus or Fable for this?'
sleep 1.2

# One-sentence answer.
echo "No — it's mechanical shell edits (df check, log rotation, staleness alert), so sonnet handles it fine."

# Hold on the final frame before the loop/end.
sleep 2
