module ParseIt where

import Prelude hiding (between, when)
import Effect (Effect)
import Effect.Console (logShow)

import Data.Maybe (fromMaybe)
import Data.List.NonEmpty (NonEmptyList)
import Data.Char (fromCharCode)
import Data.Foldable (foldMap)
import Data.String.CodeUnits (singleton)
import Text.Parsing.StringParser (Parser, runParser)
import Text.Parsing.StringParser.Combinators (many1, sepBy1, many1Till)
import Text.Parsing.StringParser.CodeUnits (string, satisfy, anyChar)

line :: String
line = "五湖四海 五湖四海 [wu3 hu2 si4 hai3] /all parts of the country/"

hanzi :: Parser String
hanzi = do
  cs <- many1 $ satisfy \c -> c >= start && c <= end
  pure $ foldMap singleton cs
  where
    start = fromMaybe '?' $ fromCharCode 0x4e00
    end = fromMaybe '?' $ fromCharCode 0x9fff

syllable :: Parser String
syllable = letters <> number
  where
    letters = do
      cs <- many1 $ satisfy \c -> c >= 'a' && c <= 'z'
      pure $ foldMap singleton cs
    number = singleton <$> satisfy \c -> c >= '1' && c <= '4'

pinyin :: Parser (NonEmptyList String)
pinyin = sepBy1 syllable (string " ")

gloss :: Parser String
gloss = do
  cs <- slash *> many1Till anyChar slash
  pure $ foldMap singleton cs
  where slash = string "/"

main :: Effect Unit
main = do
  -- logShow $ runParser (many (string "a")) "aaa"

  logShow $ runParser pinyin "wu3 hu2 si4 hai3"

  logShow $ runParser gloss "/all parts of the country/"

  logShow $ runParser (hanzi <> string " " <> hanzi) line
