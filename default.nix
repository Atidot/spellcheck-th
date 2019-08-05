{ nixpkgs  ? import <nixpkgs> { config.allowBroken = true; config.allowUnfree = true; }
, compiler ? "ghc844"
}:
with nixpkgs;
let
  spellcheckSrc = ../spellcheck-th;

  projectPackages = hspkgs: {
    spellcheck-th     = hspkgs.callCabal2nix "spellcheck-th" "${spellcheckSrc}" {};
  };

  haskellPackages = nixpkgs.haskell.packages.${compiler}.override (old: {
    overrides = pkgs.lib.composeExtensions old.overrides
      (self: hspkgs:
        projectPackages hspkgs
      );
    });

  haskellEnv = haskellPackages.ghcWithPackages (ps: with ps; [
    spellcheck-th
  ]);

in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "spellcheck-th";
  version = "0.1.0";
  env = buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';

  buildInputs = [
    haskellEnv
    (aspellWithDicts (d: [d.en]))
  ];

  shellHook =  ''
                export LOCALE_ARCHIVE_2_27="${glibcLocales}/lib/locale/locale-archive"
                eval $(cat `which ghc` | grep "lib/ghc")
              '';

}
