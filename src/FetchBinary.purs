module FetchBinary where

import Prelude
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Aff (launchAff_)
import Node.Buffer (fromArrayBuffer)
import Node.FS.Aff (exists, writeFile)
import Foreign.Object (lookup)
import Milkis as M
import Milkis.Impl.Node (nodeFetch)

fetch :: M.Fetch
fetch = M.fetch nodeFetch

url :: String
url = "https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz"

filename :: String
filename = "cedict.gz"

main :: Effect Unit
main = launchAff_ do
  fileExists <- exists filename
  case fileExists of
    true -> do
      liftEffect $ log $ "File " <> filename <> " already exists"
      pure unit
    false -> do
      response <- fetch (M.URL url) M.defaultFetchOptions
      let headers = M.headers response
      let contentLength = fromMaybe "n/a" $ lookup "content-length" headers
      liftEffect $ log $ "Content length: " <> contentLength
      arrayBuffer <- M.arrayBuffer response
      buffer <- liftEffect $ fromArrayBuffer arrayBuffer
      writeFile filename buffer
