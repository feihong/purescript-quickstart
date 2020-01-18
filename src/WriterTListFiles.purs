module WriterTListFiles where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_)
import Data.Int (fromNumber)
import Data.Tuple (Tuple(..))
import Data.Maybe (fromMaybe)
import Data.Traversable (for_, sequence)
import Data.Array ((!!))
import Node.FS.Aff (readdir, stat)
import Node.FS.Stats (Stats(..), isDirectory)
import Node.Process (argv)

listFiles :: String -> Aff (Array (Tuple String Int))
listFiles root = do
  files <- readdir root
  join <$> sequence (getPair root <$> files)
  where
    getPair :: String -> String -> Aff (Array (Tuple String Int))
    getPair path child = do
      let path' = path <> "/" <> child
      stats <- stat path'
      let Stats { size } = stats
      if isDirectory stats then
        listFiles path'
      else
        pure $ [Tuple path' (fromMaybe 0 $ fromNumber size)]

main :: Effect Unit
main = do
  root <- (\args -> fromMaybe "." $ args !! 2) <$> argv
  launchAff_ do
    files <- listFiles root
    for_ files (liftEffect <<< logShow)
