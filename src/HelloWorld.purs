module  HelloWorld where

import Prelude

import Effect (Effect, forE)
import Effect.Random (randomInt)
import Effect.Console (log)
import Data.Char (fromCharCode)
import Data.Maybe (fromMaybe)

randomHanzi :: Effect Char
randomHanzi = do
  c <- fromCharCode <$> randomInt 0x4e00 0x9fff
  pure $ fromMaybe '?' c


main :: Effect Unit
main = do
  forE 1 10 $ \i -> do
    c <- randomHanzi
    log $ show c
