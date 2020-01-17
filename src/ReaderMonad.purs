module ReaderMonad where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Control.Monad.Reader (Reader, runReader, ask, asks)

type Env =
  { foo :: String
  , bar :: Int
  }

doStuff :: Reader Env String
doStuff = do
  env <- ask
  pure $ "Do stuff with foo=" <> env.foo <> " and bar=" <> show env.bar

doStuff2 :: Reader Env String
doStuff2 = do
  foo <- asks \e -> e.foo
  bar <- asks \e -> e.bar
  pure $ "Do stuff with foo=" <> foo <> " and bar=" <> show bar

main :: Effect Unit
main = do
  logShow $ runReader doStuff { foo: "Fooey", bar: 88 }

  logShow $ runReader doStuff2 { foo: "Fooey", bar: 88 }
