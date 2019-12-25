module  HelloWorld where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Data.Char (fromCharCode)
import Data.Maybe (fromMaybe)
import Data.List.Lazy ((..))
import Data.Traversable (for)
import Data.Foldable (fold)
import Data.String.CodeUnits (singleton)

randomHanzi :: Int -> Effect String
randomHanzi n = do
  fold <$> for (1..n) \_ -> randomString
  where
    randomString = do
      -- Will never return '?' in practice
      c <- (fromMaybe '?') <<< fromCharCode <$> randomInt 0x4e00 0x9fff
      pure $ singleton c

main :: Effect Unit
main = do
  s <- randomHanzi 8
  log s

  -- Alternate ways of using randomHanzi
  randomHanzi 9 >>= \x -> log x
  randomHanzi 10 >>= log
  join $ log <$> randomHanzi 11
