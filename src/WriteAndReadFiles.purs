module WriteAndReadFiles where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Node.FS.Sync (writeTextFile, readTextFile)
import Node.Encoding (Encoding(..))

main :: Effect Unit
main = do
  writeTextFile UTF8 "output.txt" "你好世界！"
  log "Wrote to output.txt"

  text <- readTextFile UTF8 "output.txt"
  log $ "Contents of output.txt: " <> text
