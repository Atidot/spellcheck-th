{ nixpkgs  ? import <nixpkgs> { config.allowBroken = true; config.allowUnfree = true;}
, compiler ? "ghc844"
, haskellPackages ? nixpkgs.haskell.packages.${compiler}
}:
with nixpkgs;
let
  ease = package: haskell.lib.doJailbreak (haskell.lib.dontHaddock (haskell.lib.dontCheck package));
  #----
  spellcheckSrc = ../spellcheck-th;

  projectPackages = hspkgs: {
    spellcheck-th     = hspkgs.callCabal2nix "spellcheck-th" "${spellcheckSrc}" {};
  };
in
haskellPackages.override (old: {
  overrides = pkgs.lib.composeExtensions old.overrides
    (self: hspkgs:
      projectPackages hspkgs
    );
})
