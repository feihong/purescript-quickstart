module  HelloWorld where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Data.Char (fromCharCode)
import Data.Maybe (Maybe(..))
import Data.List.Lazy ((..))
import Data.Traversable (for)
import Data.Foldable (fold)
import Data.String.CodeUnits (singleton)

randomHanzi :: Int -> Effect String
randomHanzi n = do
  fold <$> for (1..n) \_ -> randomString
  where
    randomString = do
      c <- fromCharCode <$> randomInt 0x4e00 0x9fff
      pure $ singleton $ case c of
                            Just c' -> c'
                            Nothing -> ' '  -- unreachable

main :: Effect Unit
main = do
  s <- randomHanzi 8
  log s

  -- Alternate ways of using randomHanzi
  randomHanzi 9 >>= \x -> log x
  randomHanzi 10 >>= log
  join $ log <$> randomHanzi 11
  log =<< randomHanzi 12
