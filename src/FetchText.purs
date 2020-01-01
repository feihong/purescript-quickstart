module FetchText where

import Prelude
import Data.Either (Either(Left, Right))
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Aff (launchAff_, attempt)
import Milkis as M
import Milkis.Impl.Node (nodeFetch)

fetch :: M.Fetch
fetch = M.fetch nodeFetch

main :: Effect Unit
main = launchAff_ do
  _response <- attempt $ fetch (M.URL "https://ipecho.net/plain") M.defaultFetchOptions
  case _response of
    Left e -> do
      liftEffect $ log $ "Failed with " <> show e
    Right response -> do
      let code = M.statusCode response
      liftEffect $ log $ "Status code: " <> show code
      content <- M.text response
      liftEffect $ log $ "Body: " <> show content
