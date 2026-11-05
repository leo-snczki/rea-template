# Project skills

Claude Code must run inside the devShell (`nix develop`, or direnv with
`use flake`): it links the skill into `.claude/skills/` and puts its tools
on PATH. If the skill is missing, enter the devShell and restart Claude.

- `reverse-engineer-anything`: reverse engineer binaries, packaged and
  Electron/JS apps, firmware and web apps when the answer depends on the
  shipped artifact rather than source code (how a closed app works,
  what changed between versions, decompiling). The skill gives the
  workflow; the `rea` MCP server (`.mcp.json`) gives the tools, so use
  both together. Skip it for ordinary source-repository analysis.
