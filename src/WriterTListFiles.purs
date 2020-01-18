module WriterTListFiles where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_)
import Effect.Aff.Class (liftAff)
import Data.Int (fromNumber)
import Data.Tuple (Tuple(..))
import Data.Maybe (fromMaybe)
import Data.Traversable (for_, sequence)
import Data.Array ((!!))
import Node.FS.Aff (readdir, stat)
import Node.FS.Stats (Stats(..), isDirectory)
import Node.Process (argv)
import Control.Monad.Writer (WriterT, tell, execWriterT)

listFiles :: String -> Aff (Array (Tuple String Int))
listFiles root = do
  files <- readdir root
  join <$> sequence (getPair root <$> files)
  where
    -- todo: exclude files that start with .
    getPair :: String -> String -> Aff (Array (Tuple String Int))
    getPair path child = do
      let path' = path <> "/" <> child
      stats <- stat path'
      let Stats { size } = stats
      if isDirectory stats then
        listFiles path'
      else
        pure $ [Tuple path' (fromMaybe 0 $ fromNumber size)]

listFilesUsingWriterT :: String -> WriterT (Array (Tuple String Int)) Aff Unit
listFilesUsingWriterT root = do
  files <- liftAff $ readdir root
  for_ files \file -> do
    let path = root <> "/" <> file
    stats <- liftAff $ stat path
    let Stats { size } = stats
    if isDirectory stats then
      listFilesUsingWriterT path
    else
      tell $ [Tuple path (fromMaybe 0 $ fromNumber size)]

main :: Effect Unit
main = do
  root <- (\args -> fromMaybe "." $ args !! 2) <$> argv
  launchAff_ do
    -- files <- listFiles root
    -- for_ files (liftEffect <<< logShow)

    let writer = listFilesUsingWriterT root
    files <- execWriterT writer
    for_ files (liftEffect <<< logShow)
