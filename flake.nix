{
  description = "A Nix flake for the Cromite";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = false;

      systems = [
        "x86_64-linux"
      ];

      flake = {
        overlays.default = final: prev: {
          cromite = self.packages.${final.stdenv.hostPlatform.system}.cromite;
        };
      };

      perSystem =
        { config, pkgs, ... }:
        {
          packages = {
            default = config.packages.cromite;
            cromite = pkgs.callPackage ./package.nix { };
          };

          apps =
            let
              app = {
                type = "app";
                program = "${config.packages.cromite}/bin/cromite";
                inherit (config.packages.cromite) meta;
              };
            in
            {
              default = app;
              cromite = app;
            };
        };
    };
}
