module HelloWorldAff where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_, delay)
import Data.Char (fromCharCode)
import Data.Maybe (fromMaybe)
import Data.List.Lazy ((..))
import Data.Traversable (for)
import Data.Foldable (fold)
import Data.String.CodeUnits (singleton)
import Data.Time.Duration (Milliseconds(..))

slowRandomHanzi :: Int -> Aff String
slowRandomHanzi n = do
  _ <- delay (Milliseconds 1000.0)
  liftEffect $ fold <$> for (1..n) \_ -> randomString
  where
    randomString = do
      -- Will never return '?' in practice
      c <- (fromMaybe '?') <<< fromCharCode <$> randomInt 0x4e00 0x9fff
      pure $ singleton c


main :: Effect Unit
main = launchAff_ do
  s <- slowRandomHanzi 8
  liftEffect $ log s

