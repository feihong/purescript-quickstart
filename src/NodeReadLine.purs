module NodeReadline where

import Prelude
import Data.Either (Either(Right))
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_, bracket, makeAff, nonCanceler)
import Node.Path (FilePath)
import Node.FS.Stream (createReadStream)

import MyReadLine (createInterface, setLineHandler, setCloseHandler, close) as RL

forEachLine :: FilePath -> (String -> Effect Unit) -> Aff Unit
forEachLine path lineHandler =
  bracket open close \interface ->
    makeAff \finish -> do
      RL.setLineHandler interface lineHandler

      RL.setCloseHandler interface do
        log "in close handler"
        finish $ Right unit

      pure nonCanceler
  where
    open = liftEffect $ do
      rs <- createReadStream path
      RL.createInterface rs mempty
    close interface =
      liftEffect $ RL.close interface

main :: Effect Unit
main = launchAff_ do
  forEachLine "output.txt" \line -> log $ "Line: " <> line

  liftEffect $ log "Done reading lines!"
