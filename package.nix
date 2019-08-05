{ nixpkgs  ? import <nixpkgs> { config.allowBroken = true; config.allowUnfree = true; }
, compiler ? "ghc844"
}:
with nixpkgs;
let
    spellcheck-th = import ./default.nix {nixpkgs = nixpkgs; compiler = compiler;};
in
   pkgs.haskell.lib.sdistTarball spellcheck-th
