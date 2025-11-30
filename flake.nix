{
  description = "sxwm overlay for nixpkgs";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
  {
    nixpkgs.overlays.default = final: prev: {
      sxwm = prev.stdenv.mkDerivation {
        pname = "sxwm";
        version = "1.7";

        src = prev.fetchgit {
          url = "https://github.com/uint23/sxwm.git";
          rev = "v1.7";
          sha256 = "sha256-Gytop4lYkQdVaYXWyXmlHotEFnaA0O8CZUmqfIe8X2w=";
          fetchSubmodules = false;
          deepClone = false;
        };

        installPhase = ''
          make clean
          make PREFIX=$out install
          cat > $out/share/xsessions/sxwm.desktop <<EOF
[Desktop Entry]
Name=sxwm
Comment=sxwm Window Manager
Exec=$out/bin/sxwm
Type=XSession
EOF
        '';

        buildInputs = [
          prev.xorg.libX11
          prev.xorg.libXinerama
          prev.xorg.libXcursor
        ];

        nativeBuildInputs = [
          prev.libgcc
          prev.gnumake
        ];

        passthru.providedSessions = [ "sxwm" ];

        meta = with prev.lib; {
          description = "sxwm window manager";
          platforms = platforms.linux;
        };

      };
      sxbar = prev.stdenv.mkDerivation {
        pname = "sxbar";
        version = "1.0";
        src = prev.fetchgit {
          url = "https://github.com/uint23/sxbar.git";
          rev = "v1.0";
          sha256 = "sha256-wAOTUUpMAnnvFOQKgs7BCAg+CurrpY1bQL8hW3DMPps=";
          fetchSubmodules = false;
          deepClone = false;
        };

        installPhase = ''
          make clean
          make PREFIX=$out install
        '';

        buildInputs = [
          prev.xorg.libX11
          prev.xorg.libXcursor
          prev.xorg.libXinerama
        ];

        nativeBuildInputs = [
          prev.gnumake
          prev.libgcc
        ];
      };
    };
  };
}
