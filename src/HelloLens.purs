module HelloLens where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Data.Tuple (Tuple(..))
import Data.Lens (view, set, over, _1, _2)

main :: Effect Unit
main = do
  logShow $ view _1 $ Tuple 6 "six"

  logShow $ view _2 $ Tuple 6 "six"

  logShow $ set _1 7 $ Tuple 6 "six"

  logShow $ set _2 "seven" $ Tuple 6 "six"

  logShow $ over _1 (_ + 1) $ Tuple 6 "six"

  logShow $ over _2 (_ <> " cakes") $ Tuple 6 "six"
