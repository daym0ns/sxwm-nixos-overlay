# sxwm-nixos-overlay

### Installation
This only works with nix flakes.
```
inputs.sxwm-overlay.url = "github:daym0ns/sxwm-nixos-overlay"
```


then in outputs you can access the overlay under self.inputs.sxwm-overlay.nixpkgs.overlays.default
```
outputs =
    { self, nixpkgs, ... }:

    let
      pkgsOverlay = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.inputs.sxwm-overlay.nixpkgs.overlays.default ];
      };
    in
    {
      nixosConfigurations.nixdev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        pkgs = pkgsOverlay;
        modules = [ ... ];
      };
    }

```

you can install the packages with pkgs.sxwm and pkgs.sxbar
