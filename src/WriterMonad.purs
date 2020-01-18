-- http://adit.io/posts/2013-06-10-three-useful-monads.html
module WriterMonad where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Control.Monad.Writer (Writer, runWriter, tell)

half :: Int -> Writer String Int
half x = do
  tell $ "I have just halved " <> show x <> "! "
  pure $ x / 2

main :: Effect Unit
main = do
  logShow $ runWriter $ half 16

  logShow $ runWriter $ half 16 >>= half

  logShow $ runWriter $ half 16 >>= half >>= half
