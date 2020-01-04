module NodeReadline where

import Prelude
import Data.Either (Either(Right))
import Data.Maybe (Maybe(..))
import Data.Array (index)
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_, bracket, makeAff, nonCanceler)
import Node.Path (FilePath)
import Node.Stream (pipe)
import Node.FS.Stream (createReadStream)
import Node.Process (argv)

import Zlib (createGunzip)
import MyReadLine as RL

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
      gz <- createGunzip
      _ <- rs `pipe` gz
      RL.createInterface gz mempty
    close interface =
      liftEffect $ RL.close interface

main :: Effect Unit
main = launchAff_ do
  argv <- liftEffect argv
  case index argv 2 of
    Nothing ->
      liftEffect $ log "You must specify a file name"
    Just filename -> do
      forEachLine filename \line -> log $ "Line: " <> line
      liftEffect $ log "Done reading lines!"
