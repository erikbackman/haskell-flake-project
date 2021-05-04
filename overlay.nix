final: prev: {
  mine = {
    # We could just have done this directly in ./flake.nix but adding the package
    # using an overlay keeps ./flake.nix a bit cleaner
    hello = prev.callPackage ./src
      { compiler = prev.haskell.packages.ghc884;
      };
  };
}
