module NodeStream where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Node.FS.Stream (createReadStream)
import Node.Encoding (Encoding(UTF8))
import Node.Stream (onDataString, onClose)

main :: Effect Unit
main = do
  rs <- createReadStream "output.txt"

  onDataString rs UTF8 \s ->
    log s

  onClose rs (log "stream closed")

  -- log "Done reading"
