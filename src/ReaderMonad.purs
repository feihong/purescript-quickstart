module ReaderMonad where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Control.Monad.Reader (Reader, runReader, ask, asks, local)

type Env =
  { foo :: String
  , bar :: Int
  }

env :: Env
env = { foo: "Fooey", bar: 88 }

doStuff :: Reader Env String
doStuff = do
  env' <- ask
  pure $ "Do stuff with foo=" <> env'.foo <> " and bar=" <> show env'.bar

doStuff2 :: Reader Env String
doStuff2 = do
  foo <- asks \e -> e.foo
  bar <- asks \e -> e.bar
  pure $ "Do stuff with foo=" <> foo <> " and bar=" <> show bar

main :: Effect Unit
main = do
  logShow $ runReader doStuff env

  logShow $ runReader doStuff2 env

  logShow $ runReader (local (\e -> e { bar = 888 }) doStuff2) env

  logShow $ runReader (local (\e -> e { foo = "Kaboom" }) doStuff2) env
