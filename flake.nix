{
  description = "hello";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell/master";
  };

  outputs = { self, nixpkgs, flake-utils, devshell  }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay (import ./overlay.nix) ];
        };

        tooling = with pkgs; [
          haskellPackages.haskell-language-server
          ghc
          cabal-install
          rnix-lsp
        ];

      in rec {
        devShell = pkgs.devshell.mkShell {
          name = "hello-nix";
          packages = tooling;
        };

        packages = flake-utils.lib.flattenTree {
          hello = pkgs.mine.hello; # See ./overlay.nix
        };

        defaultPackage = packages.hello;
      }
    );
}
