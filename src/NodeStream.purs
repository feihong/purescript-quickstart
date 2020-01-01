module NodeStream where

import Prelude
import Data.String as String
import Data.Either (Either(Right))
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_, makeAff, nonCanceler)
import Node.Path (FilePath)
import Node.FS.Stream (createReadStream)
import Node.Encoding (Encoding(UTF8))
import Node.Stream (onDataString, onClose)

forDataInFile :: FilePath -> (String -> Effect Unit) -> Aff Unit
forDataInFile path onData = makeAff \finish -> do
  log $ "Opening " <> path
  rs <- createReadStream path

  onDataString rs UTF8 onData

  onClose rs do
    log "Stream closed"
    finish $ Right unit

  pure nonCanceler

main :: Effect Unit
main = launchAff_ do
  forDataInFile "output.txt" \s -> do
    log $ "data: " <> show (String.length s) <> " -> " <> String.take 20 s

  liftEffect $ log "Done reading!"
