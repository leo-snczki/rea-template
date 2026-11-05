{
  description = "Project template with the REA reverse-engineering skill and MCP server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # REA skill source; pinned to a release so it matches the rea-agents MCP server.
    rea = {
      url = "github:morluto/rea/rea-agents-6.8.0";
      flake = false;
    };
  };

  outputs = { nixpkgs, rea, ... }:
    let
      lib = nixpkgs.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs:
        let
          # rea-agents (the MCP server) is not in nixpkgs; npx runs the release
          # that matches the pinned skill source. .mcp.json calls it by name.
          reaVersion = (lib.importJSON "${rea}/package.json").version;
          rea-mcp = pkgs.writeShellScriptBin "rea-mcp" ''
            # rea's scripts use `#!/usr/bin/env node`, so node must be on PATH.
            export PATH=${pkgs.nodejs_26}/bin:$PATH
            exec npx -y rea-agents@${reaVersion} mcp "$@"
          '';
        in
        {
          default = pkgs.mkShell {
            packages = [ rea-mcp ];

            # Link the skill into the project's .claude/skills (gitignored).
            shellHook = ''
              root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
              mkdir -p "$root/.claude/skills"
              ln -sfn ${rea}/.agents/skills/reverse-engineer-anything "$root/.claude/skills/reverse-engineer-anything"
            '';
          };
        });
    };
}
