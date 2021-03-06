module HelloParsing where

import Prelude hiding (between, when)
import Effect (Effect)
import Effect.Console (logShow, log)

import Control.Alt ((<|>))
import Data.Tuple (Tuple(..))
import Data.Either (Either(..))
import Data.Maybe (fromMaybe)
import Data.List.NonEmpty (NonEmptyList)
import Data.Char (fromCharCode)
import Data.Foldable (foldMap)
import Data.String (drop)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.String.CodeUnits (singleton)
import Text.Parsing.StringParser (Parser, runParser, unParser)
import Text.Parsing.StringParser.Combinators (many1, sepBy1, many1Till, between)
import Text.Parsing.StringParser.CodeUnits (string, satisfy, anyChar)

type Entry =
  { traditional :: String
  , simplified :: String
  , pinyin :: NonEmptyList Syllable
  , gloss :: String
  }

data Tone = First | Second | Third | Fourth | Neutral

derive instance genericTone :: Generic Tone _

instance showTone :: Show Tone where
  show = genericShow

type Syllable =
  { phoneme :: String
  , tone :: Tone }

line :: String
line = "慢動作 慢动作 [wu3 hu2 si4 hai3] /all parts of the country/"

hanzi :: Parser String
hanzi = do
  cs <- many1 $ satisfy \c -> c >= start && c <= end
  pure $ foldMap singleton cs
  where
    start = fromMaybe '?' $ fromCharCode 0x4e00
    end = fromMaybe '?' $ fromCharCode 0x9fff


syllable :: Parser Syllable
syllable =
  -- Would be easier to use do notation, this is for demonstration
  mkSyllable <$> letters <*> tone_
  where
    letters = do
      cs <- many1 $ satisfy \c -> c >= 'a' && c <= 'z'
      pure $ foldMap singleton cs
    mkSyllable phoneme tone = { phoneme: phoneme, tone: tone }

tone_ :: Parser Tone
tone_ = string "1" $> First
  <|> string "2" $> Second
  <|> string "3" $> Third
  <|> string "4" $> Fourth
  <|> string "" $> Neutral

pinyin_ :: Parser (NonEmptyList Syllable)
pinyin_ = sepBy1 syllable (string " ")

gloss_ :: Parser String
gloss_ = do
  cs <- many1Till anyChar slash
  pure $ foldMap singleton cs
  where slash = string "/"

entry :: Parser Entry
entry = do
  traditional <- hanzi
  _ <- string " "
  simplified <- hanzi
  _ <- string " ["
  pinyin <- pinyin_
  _ <- string "] /"
  gloss <- gloss_
  pure { traditional, simplified, pinyin, gloss }

main :: Effect Unit
main = do
  let demo = (between (string "[") (string "]") (many1 $ string "a"))
  logShow $ runParser demo "[aaaa]"

  -- Simple error
  logShow $ runParser demo "[aaab]"

  -- Better error with position:
  case unParser demo { pos: 0, str: "[aata]" } of
    Left { error, pos } ->
      log $ "Position " <> show pos <> ": " <> show error
    Right s -> logShow s

  logShow $ runParser (Tuple <$> hanzi <*> (string " " *> hanzi)) line

  logShow $ runParser pinyin_ "wu3 hu2 si4 hai3 ning jing"

  logShow $ runParser (string "/" *> gloss_) "/all parts of the country/"

  logShow $ runParser entry line

  case unParser entry { pos: 0, str: line <> "some extra stuff" } of
    Left e -> logShow e
    Right { suffix: { pos, str }} -> do
      log $ "At position " <> show pos <> ": " <> drop pos str
