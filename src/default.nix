{ pkgs, compiler ? "ghc884" }:
pkgs.haskell.packages.${compiler}.callCabal2nix "hello" ./. { }
