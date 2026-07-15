# brevity-skills

A Claude Code plugin (`brev`) that adds slash commands to constrain response length and format: one sentence, or one paragraph.

## Commands

> **Note:** Claude Code namespaces every plugin skill under the plugin's name. The commands are `/brev:1s` and `/brev:1p` — a bare `/1s` or `/1p` will not work once this is installed as a plugin.

- `/brev:1s <question>` — answer in exactly one sentence (at most two if the answer truly cannot be compressed further without becoming hollow or misleading). The sentence is a hard constraint, not a target to fill: fit the single most important, substantive claim into it, don't pad or hedge to reach length. No preamble, no headers, no bullet points, no offer to elaborate.
- `/brev:1p <question>` — answer in exactly one paragraph of continuous prose. The paragraph is a hard constraint, not a sentence-count target: use as few or as many sentences as the real content needs, capped at one paragraph. No headers, no bullet points, no numbered lists, no separate sections, no preamble, no offer to elaborate.

Both constraints apply **only to the single response immediately following the command invocation.** They do not carry over to later turns — once Claude has answered, it returns to normal response length and formatting unless the command is invoked again.

## Install (recommended)

Install via Claude Code's plugin marketplace feature. Run these as slash commands inside Claude Code:

```
/plugin marketplace add louixs/brevity-skills
/plugin install brev@brevity-skills
/reload-plugins
```

(`louixs/brevity-skills` is the GitHub `owner/repo` shorthand that `/plugin marketplace add` accepts directly for GitHub-hosted marketplaces; `brevity-skills` is the marketplace name declared in `.claude-plugin/marketplace.json`, and `brev` is the plugin name inside it.)

### Usage

```
/brev:1s What year did the Berlin Wall fall?
/brev:1p Summarize the tradeoffs between REST and GraphQL.
```

## Optional: shorter aliases via symlink

This is an optional, power-user shortcut — not the primary install path above.

Because plugin skills are namespaced (`/brev:1s`, not `/1s`), the only way to get a bare `/1s`/`/1p` invocation is to bypass the plugin system and register the skill files directly as personal (non-plugin) commands. Symlink them into your own commands directory:

```sh
# Global (all projects)
ln -s "$(pwd)/skills/1s/SKILL.md" ~/.claude/commands/1s.md
ln -s "$(pwd)/skills/1p/SKILL.md" ~/.claude/commands/1p.md

# Project-local
ln -s "$(pwd)/skills/1s/SKILL.md" /path/to/project/.claude/commands/1s.md
ln -s "$(pwd)/skills/1p/SKILL.md" /path/to/project/.claude/commands/1p.md
```

This requires a local clone of this repo (rather than installing through `/plugin`) since the symlink targets point at files inside the clone. Because it's a symlink rather than a copy, running `git pull` in the clone updates the content both commands see — you keep getting upstream changes, you just skip the plugin marketplace's version tracking and `/reload-plugins` mechanics. You lose: plugin-manager visibility, marketplace-driven update notifications, and the `/brev:` namespace (so it can collide with any other command literally named `1s` or `1p`).

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2026 10yx.

Author: louixs (10yx) — https://10yx.co
