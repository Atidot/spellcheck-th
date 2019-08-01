{-# LANGUAGE PackageImports #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE CPP #-}
module Spellcheck.TH where


import           "base"             Data.Typeable (cast)
import           "base"             Data.Monoid ((<>))
import           "base"             Data.List (isPrefixOf, isSuffixOf)
import           "base"             Data.String (IsString, fromString)
import           "base"             System.Exit (ExitCode(..))
import           "base"             System.IO (hPutStr, hGetContents)
import           "text"             Data.Text (Text, pack, unpack)
import           "template-haskell" Language.Haskell.TH
import           "template-haskell" Language.Haskell.TH.Syntax
import           "template-haskell" Language.Haskell.TH.Quote
import           "process"          System.Process


_spellcheck :: String -> IO String
_spellcheck s = do
    (exitCode, output, _) <- readCreateProcessWithExitCode (proc "aspell" ["list"]) s
    case exitCode of
        -- silently continue without checking if no 'aspell'..
        ExitFailure e -> fail $ show e -- return ""
        ExitSuccess   -> do
            return output


liftText :: Text -> Q Exp
liftText txt = AppE (VarE 'pack) <$> lift (unpack txt)


strToExp str = dataToExpQ (fmap liftText . cast) (pack str)


#if 1
sc :: QuasiQuoter
sc = QuasiQuoter
   { quoteExp = \str -> do
        misspelled <- runIO $ _spellcheck str
        case misspelled of
            "" -> strToExp str
            _  -> fail $ "Misspelled words: \n" <> misspelled
   , quotePat  = error "Usage as a parttern is not supported"
   , quoteType = error "Usage as a type is not supported"
   , quoteDec  = error "Usage as a declaration is not supported"
   }
#else
sc :: QuasiQuoter
sc = QuasiQuoter
   { quoteExp = \str -> strToExp str
   , quotePat  = error "Usage as a parttern is not supported"
   , quoteType = error "Usage as a type is not supported"
   , quoteDec  = error "Usage as a declaration is not supported"
   }
#endif
