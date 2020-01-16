module HelloRegex where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String.Regex (Regex, match)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Array.NonEmpty (tail)
import Data.Array (catMaybes)
import Effect (Effect)
import Effect.Console (log, logShow)

type Entry =
  { traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

line :: String
line = "慢動作 慢动作 [man4 dong4 zuo4] /slow motion/"

regex :: Regex
regex = unsafeRegex """^(.+) (.+) \[(.+)\] \/(.+)\/$""" noFlags

lineToEntry :: String -> Maybe Entry
lineToEntry line' = join $ map go $ match regex line'
  where
    go arr =
      case catMaybes $ tail arr of
        [traditional, simplified, pinyin, gloss] ->
          Just { traditional, simplified, pinyin, gloss }
        _ -> Nothing

main :: Effect Unit
main = do
  case lineToEntry line of
    Nothing -> log "Failed to parse"
    Just entry -> logShow entry
