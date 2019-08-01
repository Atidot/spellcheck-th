{-# LANGUAGE PackageImports #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE CPP #-}
module Main where

import "template-haskell" Language.Haskell.TH
import "text"             Data.Text
import "spellcheck-th"    Spellcheck.TH

main :: IO ()
main = return () -- do
    --putStrLn . unpack $ [sc|hello world what's up "this" should `work` 123|]
