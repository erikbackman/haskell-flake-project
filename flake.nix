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
          overlays = [ devshell.overlay ];
        };
        haskellPackages = pkgs.haskellPackages;
        tooling = with pkgs; [
          haskellPackages.haskell-language-server
          ghc
          cabal-install
        ];
      in {
        devShell = pkgs.devshell.mkShell {
          name = "hello-nix";
          packages = tooling;
        };

        defaultPackage = pkgs.callPackage ./src
          { inherit pkgs;
            compiler = "ghc884";
          };
      }); # // { overlay = import ./overlay.nix {}; };
}
