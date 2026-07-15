# brevity-skills

A small pack of Claude Code slash commands that constrain response length and format.

## Commands

- `/1s <question>` — answer in exactly one sentence (at most two if truly necessary). No preamble, no headers, no bullet points, no offer to elaborate.
- `/1p <question>` — answer in exactly one paragraph (roughly 3-6 sentences of continuous prose). No headers, no lists, no separate sections, no preamble, no offer to elaborate.

Both constraints are scoped to apply only to the single response immediately following the command invocation — they do not carry over to later turns in the same conversation.

## Install

Copy or symlink the command files into your commands directory:

```sh
# Global (all projects)
ln -s "$(pwd)/commands/1s.md" ~/.claude/commands/1s.md
ln -s "$(pwd)/commands/1p.md" ~/.claude/commands/1p.md

# Project-local
ln -s "$(pwd)/commands/1s.md" /path/to/project/.claude/commands/1s.md
ln -s "$(pwd)/commands/1p.md" /path/to/project/.claude/commands/1p.md
```

Or simply copy `commands/1s.md` and `commands/1p.md` into either location instead of symlinking.

## Usage examples

```
/1s What year did the Berlin Wall fall?
/1p Summarize the tradeoffs between REST and GraphQL.
```

## Plugin manifest

This repo includes a minimal `.claude-plugin/plugin.json` for eventual publication to a Claude Code plugin marketplace. TODO: validate this manifest against the official Claude Code plugin schema/docs before publishing — only `name`, `description`, and `version` were included based on best-effort knowledge, and the schema may require or support additional fields.
