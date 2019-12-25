module  HelloWorld where

import Prelude

import Effect (Effect)
import Effect.Random (randomInt)
import Effect.Console (log)
import Data.Char (fromCharCode)
import Data.Maybe (fromMaybe)
import Data.Array ((..))
import Data.Traversable (for)
import Data.String.CodeUnits (fromCharArray)

randomHanzi :: Int -> Effect String
randomHanzi n = do
  fromCharArray <$> for (1..n) \_ -> randomChar
  where
    randomChar = do
      c <- fromCharCode <$> randomInt 0x4e00 0x9fff
      -- Will never return '?' in practice
      pure $ fromMaybe '?' c

main :: Effect Unit
main = do
  s <- randomHanzi 8
  log s
