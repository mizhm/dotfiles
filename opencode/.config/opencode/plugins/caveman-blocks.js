// /home/minh/.local/share/caveman-blocks/bin/caveman-blocks hook --harness generic
// Caveman Blocks for OpenCode. Forwards each shell call to `caveman-blocks hook --harness generic`
// (docs/INTEGRATION.md, layer 1) and appends the one-line hint to the tool output, since OpenCode's
// before-hook has no context field. Never blocks, never rewrites, fails open: without the binary, or
// on any error, OpenCode runs exactly as it would without this file.
//
// Hand-ported to the OpenCode 2 plugin API (default export { id, setup }); the generator
// (`caveman-blocks hooks install --harness opencode`) still emits the V1 shape, which V2 does not run.
import { spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";

const INSTALLED = "/home/minh/.local/share/caveman-blocks/bin/caveman-blocks";

function binary() {
  for (const p of [INSTALLED, process.env.CAVEMAN_BLOCKS_BIN, join(homedir(), ".local/share/caveman-blocks/bin/caveman-blocks" + (process.platform === "win32" ? ".exe" : ""))]) {
    if (p && existsSync(p)) return p;
  }
  return "caveman-blocks"; // PATH; a missing binary is swallowed by hook()
}

function hook(req) {
  try {
    const r = spawnSync(binary(), ["hook", "--harness", "generic"], {
      input: JSON.stringify({ protocol: 1, harness: "opencode", ...req }),
      encoding: "utf8",
      timeout: 5000,
    });
    return r.status === 0 && r.stdout ? JSON.parse(r.stdout).hint || "" : "";
  } catch {
    return "";
  }
}

// V1 named the tool "bash"; V2 calls it "shell".
const isShell = (tool) => tool === "shell" || tool === "bash";

export default {
  id: "caveman-blocks",
  async setup(ctx) {
    const hints = new Map(); // call id -> hint from the pre phase, delivered after the call

    await ctx.tool.hook("execute.before", (event) => {
      if (!isShell(event.tool)) return;
      const input = event.input && typeof event.input === "object" ? event.input : {};
      const hint = hook({
        phase: "pre",
        session: event.sessionID,
        call_id: event.id,
        cwd: input.workdir || ctx.location?.directory,
        command: String(input.command ?? ""),
      });
      if (hint) hints.set(event.id, hint);
    });

    await ctx.tool.hook("execute.after", (event) => {
      const hint = hints.get(event.id);
      hints.delete(event.id);
      if (!hint || !event.result || typeof event.result !== "object") return;
      const result = { ...event.result };
      if (typeof result.output === "string") result.output = `${result.output}\n\n${hint}`;
      if (typeof result.content === "string") result.content = `${result.content}\n\n${hint}`;
      event.result = result;
    });

    return () => hints.clear();
  },
};
