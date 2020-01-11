module ParseIt where

import Prelude hiding (between, when)
import Effect (Effect)
import Effect.Console (logShow)

import Data.List (List)
import Data.Char (toCharCode)
import Data.Foldable (foldMap)
import Data.String.CodeUnits (singleton)
import Text.Parsing.StringParser (Parser, runParser)
import Text.Parsing.StringParser.Combinators (many, many1, between)
import Text.Parsing.StringParser.CodeUnits (string, satisfy, anyChar)

slashes :: forall a. Parser a -> Parser a
slashes = between (string "/") (string "/")

gloss :: Parser (List Char)
gloss = slashes $ many anyChar

hanzi :: Parser (String)
hanzi = do
  cs <- many1 $ satisfy \c -> let code = toCharCode c in code >= 0x4e00 && code <= 0x9fff
  pure $ foldMap singleton cs


main :: Effect Unit
main = do
  logShow $ runParser (many (string "a")) "aaa"

  logShow $ runParser hanzi "你好世界"

  logShow $ runParser gloss "//iu//"
