# rea-template

A project with the [REA](https://github.com/morluto/rea) reverse-engineering skill and its MCP server.

Template repository: create a project from it with **Use this template** on
GitHub, then:

```sh
direnv allow   # or: nix develop
claude
```

The devShell links the skill from the Nix store into `.claude/skills/`
(gitignored). The input is pinned to a REA release tag in `flake.nix`, so the
skill matches a published `rea-agents` MCP server: change the tag to update it.

The `rea` MCP server in `.mcp.json` runs `rea-mcp` from the devShell
(`npx rea-agents` at the version matching the skill), and
`.claude/settings.json` enables it without a prompt.
