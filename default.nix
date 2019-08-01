{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aspell, base, process, stdenv
      , template-haskell, text
      }:
      mkDerivation {
        pname = "spellcheck-th";
        version = "0.1.0.0";
        src = ../spellcheck-th;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [ base process template-haskell text aspell];
        libraryToolDepends = [ aspell ];
        executableHaskellDepends = [ base process template-haskell text aspell];
        testHaskellDepends = [ base process template-haskell text aspell];
        homepage = "https://github.com/githubuser/spellcheck-th#readme";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
