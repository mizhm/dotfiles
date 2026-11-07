# DSH Tool Mapping

Skills speak in actions ("dispatch a subagent", "create a todo", "read a file").
On DSH (DeepSeek Harness) these resolve to the tools below.

| Action skills request | DSH equivalent |
| --- | --- |
| Dispatch a subagent (`Subagent (general-purpose)` template, `Task` calls) | `subagent` tool; steer a running child or continue it with `send_message`. Delegation returns a child id immediately — keep doing independent work and collect the result when notified. Never invent `Task`/`Agent` tool names. |
| Task tracking ("create a todo", "mark complete", checklists) | `todo` tool, one todo per checklist item |
| Read a file | `read` tool (not shell `cat`) for inspection |
| Create or fully replace a file | `write` tool |
| Targeted file edits | `edit` tool |
| Find files / search contents | `glob` / `grep` tools |
| Run shell commands | `bash` tool (`workdir` sets the directory; long work runs in the background and is collected with `job_output`). Every result carries an `[exit code: N]` marker — investigate failures before moving on. |
| Load a skill | `skill` tool with the exact skill name. A user may also invoke `/name` directly — its `<skill_content>` block is already in context, so do not reload it. |
| Web search / fetch a URL | `web_search` / `web_fetch` tools |
| Hand final deliverables to the user | `present` tool, only for complete deliverables |

## Notes

- DSH discovers skills one level deep: `<dshHome>/skills/<name>/SKILL.md` (user-global)
  or `<projectRoot>/.dsh/skills/<name>/SKILL.md` (project). The `references/`,
  `scripts/`, and `assets/` subtrees inside a skill bundle load as that skill's
  resources, not as skills.
- DSH has no Claude-style hook system (`SessionStart`, `PreToolUse`,
  `PostToolUse`, `PreCompact`, `SubagentStart/Stop`, ...). Anything a skill
  expects a hook to do must be done explicitly with tools instead.
