# add self to overlays in flake.nix
final: prev: {
  somePackage = final.callPackage ./src;
}
