module WriterTListFiles where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_)
import Data.Int (fromNumber)
import Data.Tuple (Tuple(..))
import Data.Maybe (fromMaybe)
import Data.Traversable (for_, for)
import Node.FS.Aff (readdir, stat)
import Node.FS.Stats (Stats(..))

listFiles :: String -> Aff (Array (Tuple String Int))
listFiles path = do
  files <- readdir path
  for files \file -> do
    stats <- stat file
    let Stats { size } = stats
    pure $ Tuple (path <> "/" <> file) (fromMaybe 0 $ fromNumber size)

main :: Effect Unit
main = launchAff_ do
  files <- listFiles "."
  for_ files (liftEffect <<< logShow)
