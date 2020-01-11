module LazyList where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Data.Lazy (defer)
import Data.List.Lazy (List(..), Step(..), take, drop)
import Data.Array (fromFoldable)

makeLazyList :: Int -> List Int
makeLazyList n = List $ defer \_ ->
  Cons n $ makeLazyList (n + 1)

main :: Effect Unit
main = do
  logShow $ take 8 $ makeLazyList 1

  logShow $ fromFoldable $ take 12 $ drop 1000 $ makeLazyList 32
