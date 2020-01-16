module HelloLens where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Data.Tuple (Tuple(..))
import Data.Lens (view, _1, _2)

main :: Effect Unit
main = do
  logShow $ view _1 $ Tuple 6 "six"

  logShow $ view _2 $ Tuple 6 "six"
