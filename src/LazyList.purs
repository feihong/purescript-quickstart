module LazyList where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Data.Lazy (defer)
import Data.List.Lazy (List(..), Step(..), take)

makeLazyList :: Int -> List Int
makeLazyList n = List $ defer \_ ->
  Cons n $ makeLazyList (n + 1)

main :: Effect Unit
main = do
  logShow $ take 8 $ makeLazyList 1
