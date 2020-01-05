module NodeReadline where

import Prelude
import Data.Either (Either(Right))
import Data.Maybe (Maybe(..))
import Data.Array (index)
import Data.String.Utils (endsWith)
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Ref as Ref
import Effect.Aff (Aff, launchAff_, bracket, makeAff, nonCanceler)
import Node.Path (FilePath)
import Node.Stream (pipe)
import Node.FS.Stream (createReadStream)
import Node.Process (argv)

import Zlib (createGunzip)
import MyReadLine as RL

createInterface :: String -> Effect RL.Interface
createInterface path = do
  rs <- createReadStream path
  case path # endsWith ".gz" of
    false -> RL.createInterface rs mempty
    true -> do
      gz <- createGunzip
      _ <- rs `pipe` gz
      RL.createInterface gz mempty

forEachLine :: FilePath -> (Int -> String -> Effect Unit) -> Aff Unit
forEachLine path lineHandler =
  bracket open close \interface ->
    makeAff \finish -> do
      lineNum <- Ref.new 1
      RL.setLineHandler interface \line -> do
        lineNum' <- Ref.read lineNum
        lineHandler lineNum' line
        Ref.modify (_ + 1) lineNum

      RL.onClose interface do
        log "Inside onClose handler"
        finish $ Right unit

      pure nonCanceler
  where
    open = liftEffect $ createInterface path
    close interface = liftEffect $ RL.close interface

main :: Effect Unit
main = launchAff_ do
  argv <- liftEffect argv
  case index argv 2 of
    Nothing ->
      liftEffect $ log "You must specify a file name"
    Just filename -> do
      forEachLine filename \num line -> log $ "Line " <> show num <> ": " <> line
      liftEffect $ log "Done reading lines!"
