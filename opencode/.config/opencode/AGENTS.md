## Identity & Language

- Default response language: Vietnamese. Keep code, identifiers, paths, commands, and error output verbatim (English, as-is) — never translate them.

## OpenCode Config Layout

`~/.config/opencode` is a symlink to `dotfiles/opencode/.config/opencode`. Edits there are dotfiles edits.

- `opencode.jsonc`: providers, `plugins`, and MCP servers. V2 schema: servers live under `mcp.servers.<name>` (never directly under `mcp`), plugins under `plugins` (not the V1 `plugin` key).
- `skills/<name>/SKILL.md`: global skills. `commands/*.md`: global slash commands. `AGENTS.md`: this file.
- After touching config, verify with `opencode debug config` before claiming it works. The server reads config at start: run `opencode service restart` to apply.
- Secrets go through `{env:VAR}`, never literal values. Never commit `service.json` (holds the service password) or anything gitignored; never force-add.
- MCP: one server per need.

## Skills

- One skill = `skills/<name>/SKILL.md` plus sibling files it references by name.
- Every skill's frontmatter `description` loads into every session: keep it short and trigger-precise; put detail in the body or sibling files.
- Never reference a skill that isn't installed. Skill scripts must pass `bash -n`; test behavior changes for real.

## Skill Routing

The superpowers plugin bootstraps `using-superpowers` each session. Before a code task expected to take more than ~5 minutes — features, bug fixes, refactors, anything needing a plan — load the matching skill with the `skill` tool (brainstorming, systematic-debugging, test-driven-development, writing-plans, executing-plans, verification-before-completion). Skip this for quick questions, small edits, and read-only lookups.

- Frontend/UI design work: `impeccable` (or `/impeccable`).
- Reverse engineering binaries, apps, bundles: `reverse-engineer-anything` (REA MCP).
- Unfamiliar codebase architecture: `understand` / `understand-chat`.
- Code review or "is this over-engineered": `ponytail-review`.

## Tools (OpenCode V2)

- Shell: `shell` (`command`, `workdir`, `timeout`, `background`). Use `workdir` instead of `cd`.
- File changes: `patch` when available; otherwise `edit` for targeted changes, `write` to create/overwrite. Read before editing.
- Search: `grep`, `glob`; reading: `read`. Prefer these over shell `cat`/`find`/`grep`.
- Subagents: `subagent` with `agent: "explore"` for read-only codebase research, `agent: "general"` for multi-step work; pass `sessionID` to continue one.
- Web: `webfetch`, `websearch`. Library/API docs: the `context7` MCP before guessing from memory.
- V2 has no todo tool: for multi-step work, track the plan as a checklist in a markdown file (or the plan file a skill names) and tick items as you go.

## Code Quality

- Comment only the *why*; never restate the *what*.
- Follow the codebase's established patterns and style; prefer existing helpers over new machinery.
- DRY. YAGNI. Small functions, clear names, no dead code.
- Fix root causes, not symptoms.

## Execution

- Evidence before claims: run the command, read the output, then report. Load `verification-before-completion` before committing, opening PRs, or declaring anything fixed/passing.
- Delegate self-contained research to a `subagent` and keep working instead of polling.
- Background jobs: collect every still-relevant result before the final answer; stop what no longer matters.
- Ask only for decisions that are genuinely the user's (public, security, data, or hard-to-reverse choices); otherwise pick the sensible default and say so.

## Git Commit Guidelines

- Do NOT add any `Co-authored-by:` trailers.
- Do NOT include any promotional footers in commit messages.
- Always commit under the current local Git user author identity.
- Commit or push only when asked.

## Pull Request Guidelines

- Keep emoji/icons to a minimum in PR titles and descriptions.
- Do NOT add any "Generated with ..." or similar promotional footers to PR descriptions.
