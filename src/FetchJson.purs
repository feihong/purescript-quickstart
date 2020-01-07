module FetchJson where

import Prelude
import Data.Either (Either(Left, Right))
import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Effect.Aff (launchAff_, attempt)
import Milkis as M
import Milkis.Impl.Node (nodeFetch)
import Simple.JSON as JSON

fetch :: M.Fetch
fetch = M.fetch nodeFetch

type IpInfo =
  { ip :: String
  , city :: String
  , region :: String
  , timezone :: String
  }

main :: Effect Unit
main = launchAff_ do
  _response <- attempt $ fetch (M.URL "https://ipecho.net/json") M.defaultFetchOptions
  case _response of
    Left e -> do
      liftEffect $ log $ "Failed with " <> show e
    Right response -> do
      content <- M.json response
      liftEffect $ log $ "Status code: " <> show (M.statusCode response)

      case JSON.read content of
        Left errors -> liftEffect $ log $ show errors
        Right (r :: IpInfo) -> liftEffect $ log $ show r
