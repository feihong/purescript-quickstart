-- Do the same computation in MutableRef but using State monad instead
module StateMonad where

import Prelude

import Effect (Effect)
import Effect.Console (logShow)
import Control.Monad.State as State

sumOfSquares :: Int
sumOfSquares = State.evalState state 0
  where state = loop 100
        loop 0 = State.get
        loop n = do
          _ <- State.modify (_ + (n * n))
          loop (n - 1)

main :: Effect Unit
main = do
  logShow sumOfSquares
