# brevity

A Claude Code plugin (`brevity`) that adds slash commands to constrain response length and format: one sentence, or one paragraph.

## Commands

> **Note:** Claude Code namespaces every plugin skill under the plugin's name. The commands are `/brevity:1s` and `/brevity:1p` — a bare `/1s` or `/1p` will not work once this is installed as a plugin.

- `/brevity:1s <question>` — answer in exactly one sentence (at most two if the answer truly cannot be compressed further without becoming hollow or misleading). The sentence is a hard constraint, not a target to fill: fit the single most important, substantive claim into it, don't pad or hedge to reach length. No preamble, no headers, no bullet points, no offer to elaborate.
- `/brevity:1p <question>` — answer in exactly one paragraph of continuous prose. The paragraph is a hard constraint, not a sentence-count target: use as few or as many sentences as the real content needs, capped at one paragraph. No headers, no bullet points, no numbered lists, no separate sections, no preamble, no offer to elaborate.

Both constraints apply **only to the single response immediately following the command invocation.** They do not carry over to later turns — once Claude has answered, it returns to normal response length and formatting unless the command is invoked again.

## Install (recommended)

Install via Claude Code's plugin marketplace feature. Run these as slash commands inside Claude Code:

```
/plugin marketplace add louixs/brevity
/plugin install brevity@brevity
/reload-plugins
```

(`louixs/brevity` is the GitHub `owner/repo` shorthand that `/plugin marketplace add` accepts directly for GitHub-hosted marketplaces; `brevity` is both the marketplace name declared in `.claude-plugin/marketplace.json` and the plugin name inside it.)

### Usage

These are real question/answer pairs pulled from actual sessions — not invented examples.

#### `/brevity:1s`

For a quick decision or clarification mid-task, where you want the answer, not a discussion.

> **Ask:** Should I bump model to Opus or Fable for this?
>
> **Response:** No — it's mechanical shell edits (df check, log rotation, staleness alert), so sonnet handles it fine.

> **Ask:** Can you help me with one query I can run to research whether any similar command exists?
>
> **Response:** Search GitHub and the Claude Code plugin/skill marketplaces for `"claude code" (slash command OR skill OR plugin) "one sentence" answer length` to see if a terse/one-sentence response constraint already exists as a shared command.

#### `/brevity:1p`

For a question that deserves real reasoning, capped at one paragraph instead of a multi-section writeup.

> **Ask:** Now we are about to make this repo ready for release. No LICENSE file — GitHub defaults to "all rights reserved," which defeats the point of open-sourcing. Which license would you recommend? Note this is engineering-as-marketing to promote our company too — I'll be linking subtly to it, hoping it drives traffic and builds credibility.
>
> **Response:** MIT is the right call here: it's the most recognized permissive license, imposes zero friction on forking, modifying, or embedding into commercial products, and that recognizability itself does marketing work — developers scanning GitHub trust MIT repos instantly and won't hesitate before starring, forking, or mentioning it, which is exactly the low-friction virality you want when the real goal is audience-building rather than protecting IP in two slash-command files that have no defensible moat anyway; the only reason to reach for something else (Apache 2.0) would be if you cared about explicit patent-grant language or wanted a NOTICE file mechanism to force attribution to propagate through forks, but for a marketing-driven micro-tool that added ceremony just suppresses adoption without buying you anything, and copyleft options (GPL/AGPL) are actively counterproductive here since they'd scare off exactly the corporate/professional users you want citing and reusing this to build your credibility.

**`/1p` is still experimental.** Fitting real substance into one paragraph, as above, means long, densely clause-packed sentences — readable, but noticeably harder to skim than normal prose. On harder questions it can produce output that's technically one paragraph but pushes well past what "one paragraph" should mean in practice. If the answer needs real structure (multiple options, sequenced steps), let Claude say so and drop the constraint rather than forcing it.

## Optional: shorter aliases via symlink

This is an optional, power-user shortcut — not the primary install path above.

Because plugin skills are namespaced (`/brevity:1s`, not `/1s`), the only way to get a bare `/1s`/`/1p` invocation is to bypass the plugin system and register the skill files directly as personal (non-plugin) commands. Symlink them into your own commands directory:

```sh
# Global (all projects)
ln -s "$(pwd)/skills/1s/SKILL.md" ~/.claude/commands/1s.md
ln -s "$(pwd)/skills/1p/SKILL.md" ~/.claude/commands/1p.md

# Project-local
ln -s "$(pwd)/skills/1s/SKILL.md" /path/to/project/.claude/commands/1s.md
ln -s "$(pwd)/skills/1p/SKILL.md" /path/to/project/.claude/commands/1p.md
```

This requires a local clone of this repo (rather than installing through `/plugin`) since the symlink targets point at files inside the clone. Because it's a symlink rather than a copy, running `git pull` in the clone updates the content both commands see — you keep getting upstream changes, you just skip the plugin marketplace's version tracking and `/reload-plugins` mechanics. You lose: plugin-manager visibility, marketplace-driven update notifications, and the `/brevity:` namespace (so it can collide with any other command literally named `1s` or `1p`).

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2026 10yx.

Author: louixs (10yx) — https://10yx.co
