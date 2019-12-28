module NodeFile where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.List.Lazy ((..))
import Data.Foldable (intercalate)
import Node.FS.Sync (writeTextFile, readTextFile)
import Node.Encoding (Encoding(UTF8))

content :: String
content = intercalate "\n" lazyLines
  where lazyLines = (\x -> "你好世界" <> show x) <$> (1..8)

main :: Effect Unit
main = do
  writeTextFile UTF8 "output.txt" content
  log "Wrote to output.txt"

  text <- readTextFile UTF8 "output.txt"
  log $ "Contents of output.txt: " <> text
