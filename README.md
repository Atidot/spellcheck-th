# spellcheck-th

Running aspell in a Quasi-Quoter

## how to run

In the folder:

```bash
make shell
```

and in the opened shell:

```bash
cabal new-build
ghci
```

and in the ghci:

```bash
Prelude> :m +Spellcheck.TH
Prelude Spellcheck.TH>
```

## TODOS

* usage examples