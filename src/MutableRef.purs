-- Based on the example in https://github.com/purescript/purescript-st/blob/master/test/Main.purs
-- But, of course, less safe
module MutableRef where

import Prelude

import Effect (Effect)
import Effect.Console (logShow)
import Effect.Ref as Ref

sumOfSquares :: Effect Int
sumOfSquares = do
  total <- Ref.new 0
  let loop 0 = Ref.read total
      loop n = do
        _ <- Ref.modify (_ + (n * n)) total
        loop (n - 1)
  loop 100

main :: Effect Unit
main = do
  logShow =<< sumOfSquares
