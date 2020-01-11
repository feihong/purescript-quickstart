module RegularExpr where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String.Regex (Regex, match)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Array.NonEmpty (tail)
import Effect (Effect)
import Effect.Console (log, logShow)

line :: String
line = "慢動作 慢动作 [man4 dong4 zuo4] /slow motion/"

regex :: Regex
regex = unsafeRegex """^(.+) (.+) \[(.+)\] \/(.+)\/$""" noFlags

type Entry =
  { traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

lineToEntry :: String -> Maybe Entry
lineToEntry line' =
  case match regex line' of
    Nothing -> Nothing
    Just arr ->
      case tail arr of
        [Just traditional, Just simplified, Just pinyin, Just gloss] ->
          Just { traditional, simplified, pinyin, gloss }
        _ -> Nothing

main :: Effect Unit
main = do
  case lineToEntry line of
    Nothing -> log "Failed to parse"
    Just entry -> logShow entry
