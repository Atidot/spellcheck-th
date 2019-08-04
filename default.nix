{ nixpkgs  ? import <nixpkgs> { config.allowBroken = true; config.allowUnfree = true; }
, compiler ? "ghc844"
}:
with nixpkgs;
let
  haskellPackages = import ./haskell.nix { inherit nixpkgs compiler; };

  haskellEnv = haskellPackages.ghcWithPackages (ps: with ps; [
    spellcheck-th
  ]);

in
stdenv.mkDerivation rec {
  name = "spellcheck-th";

  env = buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';

  buildInputs = [
    haskellEnv
  ];

  shellHook =  ''
                export LOCALE_ARCHIVE_2_27="${glibcLocales}/lib/locale/locale-archive"
                eval $(cat `which ghc` | grep "lib/ghc")
              '';

}
