{-# LANGUAGE UnicodeSyntax #-}

module StringOps(cleanUp, firstMatch, join, fixHyphenation, fixWhitespace) where

import           Control.Arrow.Unicode
import           Data.List             (isSuffixOf)
import           Data.String.Utils     (replace, split)
import           Text.Regex.TDFA


cleanUp ∷ String → String
cleanUp = fixWhitespace
          ⋙ fixHyphenation
          ⋙ splitIntoSentences
          ⋙ first


fixWhitespace ∷ String → String
fixWhitespace = replace "\n" " "


fixHyphenation ∷ String → String
fixHyphenation = replace "- " ""


splitIntoSentences ∷ String → [String]
splitIntoSentences = split ". " ⋙ map ensureEndsWithPeriod


ensureEndsWithPeriod :: String -> String
ensureEndsWithPeriod sentence =
  sentence ++ (if "." `isSuffixOf` sentence then "" else ".")


--
-- Regex helpers
--
firstMatch ∷ String → String → String
firstMatch regex input =
  getFirstMatch (input =~ regex)


getFirstMatch = getAllTextMatches ⋙ first


--
-- More-conventional function names
--
first ∷ [a] → a
first = head

join ∷ [String] → String
join = unwords
