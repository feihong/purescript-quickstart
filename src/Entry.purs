module Entry where

import Prelude hiding (between, when)
import Effect (Effect)
import Effect.Console (logShow)

import Data.Maybe (fromMaybe)
import Data.Char (fromCharCode)
import Data.Foldable (class Foldable, fold, foldMap)
import Data.String.CodeUnits (singleton)
import Text.Parsing.StringParser (Parser, runParser)
import Text.Parsing.StringParser.Combinators (many1, sepBy1, many1Till, withError)
import Text.Parsing.StringParser.CodeUnits (string, satisfy, anyChar, eof)

type Entry =
  { traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

charsToString :: forall f. Foldable f => f Char -> String
charsToString = foldMap singleton

hanzi :: Parser String
hanzi =
  charsToString <$> (many1 $ satisfy \c -> c >= start && c <= end)
  where
    start = fromMaybe '?' $ fromCharCode 0x4e00
    end = fromMaybe '?' $ fromCharCode 0x9fff

pinyin_ :: Parser String
pinyin_ = fold <$> sepBy1 syllable (string " ")
  where
    syllable = letters <> tone
    letters = charsToString <$> (many1 $ satisfy \c -> c >= 'a' && c <= 'z')
    tone = singleton <$> satisfy \c -> c >= '1' && c <= '4'

gloss_ :: Parser String
gloss_ = charsToString <$> many1Till anyChar (string "/")

entry :: Parser Entry
entry = do
  traditional <- withError hanzi "Invalid traditional character"
  void $ string " "
  simplified <- withError hanzi "Invalid simplified character"
  void $ string " ["
  pinyin <- withError pinyin_ "Invalid pinyin"
  void $ string "] /"
  gloss <- withError gloss_ "Invalid gloss"
  void eof
  pure { traditional, simplified, pinyin, gloss }

main :: Effect Unit
main = do
  logShow $ runParser entry "慢動作 慢动作 [wu3 hu2 si4 hai3] /all parts of the country/"

  logShow $ runParser entry "慢動作 慢动作 [wu3 hu2 si4 hai3]  /all parts of the country/"
