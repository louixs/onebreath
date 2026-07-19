#!/bin/bash
# Canned terminal session used by after.tape to render after.gif.
# Shows the same question run through /onebreath:1s, compressed to one
# sentence. No live session or API call — every line here is scripted
# output.

type_line() {
  local text="$1"
  local i
  for ((i = 0; i < ${#text}; i++)); do
    printf '%s' "${text:$i:1}"
    sleep 0.03
  done
  echo
}

# 1. Same question, run as a slash command.
printf '%s' '❯ '
type_line '/onebreath:1s Should I bump model to Opus or Fable for this?'
sleep 1.2

# 2. One-sentence answer.
echo "No — it's mechanical shell edits (df check, log rotation, staleness alert), so sonnet handles it fine."

# 3. Hold on the final frame before the loop.
sleep 2
