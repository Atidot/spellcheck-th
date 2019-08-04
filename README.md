# spellcheck-th

Running aspell in a Quasi-Quoter

## how to run

In the folder:

```bash
make shell
```

and in the opened shell:

```bash
ghci
```

and in the ghci:

```bash
[nix-shell:~/development/spellcheck-th]$ ghci
GHCi, version 8.4.4: http://www.haskell.org/ghc/  :? for help
Prelude> :m +Spellcheck.TH
Prelude Spellcheck.TH> _spellcheck "pipk"
"pipk\n"
Prelude Spellcheck.TH> _spellcheck "pipe"
""
Prelude Spellcheck.TH>
```

## TODOS

* usage examples