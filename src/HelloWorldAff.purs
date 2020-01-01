module HelloWorldAff where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Effect.Class (liftEffect)
import Effect.Aff (Aff, launchAff_, delay)
import Data.Char (fromCharCode)
import Data.Maybe (fromMaybe)
import Data.Array ((..))
import Data.Traversable (for)
import Data.String.CodePoints (codePointFromChar, fromCodePointArray)
import Data.Time.Duration (Milliseconds(..))

slowRandomHanzi :: Int -> Aff String
slowRandomHanzi n = do
  delay (Milliseconds 1000.0)
  liftEffect $ fromCodePointArray <$> for (1..n) \_ -> randomString
  where
    randomString = do
      c <- (fromMaybe '?') <<< fromCharCode <$> randomInt 0x4e00 0x9fff
      pure $ codePointFromChar c

main :: Effect Unit
main = launchAff_ $ loop 1
  where
    loop n = do
      s <- slowRandomHanzi n
      liftEffect $ log s
      loop $ (n + 1) `mod` 9
