## Identity & Language

- Default response language: Vietnamese. Keep code, identifiers, paths, and error output verbatim (English, as-is) — never translate them.

## DSH Home Layout

This directory is the DSH home (`~/.dsh`, symlinked from `dotfiles/dsh/.dsh`).

### Profiles

- `profiles/web/cordis.patch.yml` is your layer — edit this file, never `cordis.yml` (generated base).
- After touching profile config, verify with `dsh --dump-config --profile web` before claiming it works.
- MCP servers are `dsh-mcp-client` entries in the patch file. Pin executable versions (no `@latest`); keep the set minimal — one server per need.

### Skills

- One skill = `skills/<name>/SKILL.md`, plus optional sibling files it references by name.
- The frontmatter `description` of EVERY skill loads into EVERY session: keep it short and trigger-precise. Detail goes in the body; rarely-needed detail goes in sibling files the body references.
- Skill scripts must pass `bash -n`. Test behavior changes for real before claiming they work.
- Never reference a skill that isn't installed, and never link `../<other-skill>/...` unless that directory exists.

## Skill Routing

Before starting a code task expected to take more than ~5 minutes — implementing features, fixing bugs, refactoring, or anything needing a plan — load the `using-superpowers` skill via the `skill` tool and follow it to pick the matching skill (brainstorming, systematic-debugging, test-driven-development, writing-plans, executing-plans, verification-before-completion). Skip this for quick questions, small edits, and read-only lookups. Tool names resolve per `using-superpowers/references/dsh-tools.md`.

## Code Quality

- No redundant comments: if the code already explains itself, no comment. Comment only the *why* — never restate the *what*.
- Follow best practices, clean code, and established patterns of the codebase at hand. Match surrounding style; prefer existing helpers over new machinery. No reinventing patterns that already exist in the repo.
- DRY. YAGNI. Small functions, clear names, no dead code.

## Execution

- Multi-step work: track with todos, one per concrete step; mark complete as you go.
- Background work: collect every still-relevant job before the final answer; kill what stopped mattering.
- Evidence before claims: run the command, read the output, then report. (Full protocol lives in the verification-before-completion skill — load it before committing, opening PRs, or declaring anything fixed/passing.)
- Prefer delegating self-contained research to a `subagent` and keep working meanwhile instead of polling.

## Git Commit Guidelines

- Do NOT add any `Co-authored-by:` trailers.
- Do NOT include any promotional footers in commit messages.
- Always commit under the current local Git user author identity.

## Pull Request Guidelines

- Keep emoji/icons to a minimum in PR titles and descriptions.
- Do NOT add any "Generated with ..." or similar promotional footers to PR descriptions.

## Secrets

- Never commit `.credentials.yaml`, `sessions/`, or `storages/` — they are gitignored for a reason. Never force-add them.
