# onebreath

A Claude Code plugin (`onebreath`) that adds slash commands to constrain response length and format: one sentence, or one paragraph.

## Commands

> **Note:** Claude Code namespaces every plugin skill under the plugin's name. The commands are `/onebreath:1s` and `/onebreath:1p` — a bare `/1s` or `/1p` will not work once this is installed as a plugin. (Claude Code has a known bug — [#50486](https://github.com/anthropics/claude-code/issues/50486) — where some plugin commands surface unprefixed in autocomplete; that's not something this plugin controls or guarantees, so always use the namespaced form.)

- `/onebreath:1s <question>` — answer in exactly one sentence (at most two if the answer truly cannot be compressed further without becoming hollow or misleading). The sentence is a hard constraint, not a target to fill: fit the single most important, substantive claim into it, don't pad or hedge to reach length. No preamble, no headers, no bullet points, no offer to elaborate.
- `/onebreath:1p <question>` — answer in exactly one paragraph of continuous prose. The paragraph is a hard constraint, not a sentence-count target: use as few or as many sentences as the real content needs, capped at one paragraph. No headers, no bullet points, no numbered lists, no separate sections, no preamble, no offer to elaborate.

Both constraints apply **only to the single response immediately following the command invocation.** They do not carry over to later turns — once Claude has answered, it returns to normal response length and formatting unless the command is invoked again.

## Install

### Option 1: Plugin marketplace

Install via Claude Code's plugin marketplace feature. Run these as slash commands inside Claude Code:

```
/plugin marketplace add louixs/onebreath
/plugin install onebreath@onebreath
/reload-plugins
```

(`louixs/onebreath` is the GitHub `owner/repo` shorthand that `/plugin marketplace add` accepts directly for GitHub-hosted marketplaces; `onebreath` is both the marketplace name declared in `.claude-plugin/marketplace.json` and the plugin name inside it.)

### Option 2: npx

Install the skills directly via npm, no marketplace required:

```
npx onebreath
```

This prompts you to choose between installing to the current project's `.claude/skills` or your global `~/.claude/skills`. Non-interactive flags are available for scripting: `--project`/`-p`, `--global`/`-g`, and `--yes`/`-y` (skips prompts, defaults to `--project` if no target flag is given). Skills installed this way are used as `/1s` and `/1p` (not namespaced under a plugin name, unlike the marketplace install).

### Usage

These are real question/answer pairs pulled from actual sessions — not invented examples.

#### `/onebreath:1s`

For a quick decision or clarification mid-task, where you want the answer, not a discussion.

> **Ask:** Should I bump model to Opus or Fable for this?
>
> **Response:** No — it's mechanical shell edits (df check, log rotation, staleness alert), so sonnet handles it fine.

> **Ask:** Can you help me with one query I can run to research whether any similar command exists?
>
> **Response:** Search GitHub and the Claude Code plugin/skill marketplaces for `"claude code" (slash command OR skill OR plugin) "one sentence" answer length` to see if a terse/one-sentence response constraint already exists as a shared command.

#### `/onebreath:1p`

For a question that deserves real reasoning, capped at one paragraph instead of a multi-section writeup.

> **Ask:** No LICENSE file on this repo. Which one should I use, and why?
>
> **Response:** MIT is the right call for a small open-source tool like this. It's the most recognized permissive license, so people trust it instantly and won't hesitate to fork or reuse it. Apache 2.0 only makes sense if you specifically want explicit patent-grant language or a NOTICE file to propagate attribution through forks, which is overkill here. Copyleft options like GPL would just add friction without protecting anything worth protecting in a repo this small.

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2026 10yx.

Author: louixs (10yx) — https://10yx.co
