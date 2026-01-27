# A Nix flake for Cromite

A Nix flake which allows you to use Cromite (a Bromite fork) with ad blocking and privacy enhancements. Updates automatically.

# Usage (with flakes)

Add this flake to your `inputs`

```nix
inputs.cromite = {
  url = "github:Impqxr/cromite-nix-flake"
  inputs.nixpkgs.follows = "nixpkgs";
}
```

Use an overlay (optional)

```nix
nixpkgs.overlays = [ (import inputs.cromite.overlays.default) ]
```

Then add it to your `packages`

```nix
environment.systemPackages = [
  cromite
  # if you skip the overlay step, use
  # inputs.cromite.packages.${system}.default
];
```

You also can run it directly!

```shell
# To run it
nix run github:Impqxr/cromite-nix-flake

# To install it
nix profile install github:Impqxr/cromite-nix-flake
```

# Usage (without flakes)

[Flakes aren't real and cannot hurt you](https://jade.fyi/blog/flakes-arent-real/), but if you still think otherwise, we use `flake-compat` to allow using this flake without enabled flakes in your system.

```nix
environment.systemPackages = [
  (import (
    # or better use revision instead of `main` branch
    builtins.fetchTarball "https://github.com/Impqxr/cromite-nix-flake/archive/main.tar.gz"
  )).packages.${pkgs.system}.default
];
```

Or install it directly

```shell
nix-channel --add https://github.com/Impqxr/cromite-nix-flake/archive/main.tar.gz cromite
nix-channel --update cromite

nix-env -iA cromite.default
```
