module  HelloWorld where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Data.Char (fromCharCode)
import Data.Maybe (fromMaybe)
import Data.Array ((..))
import Data.Traversable (for)
import Data.String.CodePoints (codePointFromChar, fromCodePointArray)

randomHanzi :: Int -> Effect String
randomHanzi n = do
  fromCodePointArray <$> for (1..n) \_ -> randomCodePoint
  where
    randomCodePoint = do
      -- Will never return '?' in practice
      c <- (fromMaybe '?') <<< fromCharCode <$> randomInt 0x4e00 0x9fff
      pure $ codePointFromChar c

main :: Effect Unit
main = do
  s <- randomHanzi 8
  log s

  -- Alternate ways of using randomHanzi
  randomHanzi 9 >>= \x -> log x
  randomHanzi 10 >>= log
  join $ log <$> randomHanzi 11
