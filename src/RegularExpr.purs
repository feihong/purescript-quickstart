module RegularExpr where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String.Regex (Regex, match)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Array.NonEmpty (toArray)
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

main :: Effect Unit
main = do
  case match regex line of
    Nothing -> log "No match"
    Just arr ->
      case toArray arr of
        [Just _total, Just traditional, Just simplified, Just pinyin, Just gloss] ->
          logShow { traditional, simplified, pinyin, gloss }
        _ -> log "Failed to parse"
