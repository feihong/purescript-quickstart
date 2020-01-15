module Sqlite
  ( Database
  , openDb
  , closeDb
  ) where

import Prelude
import Effect (Effect)
import Data.Function.Uncurried (Fn2, runFn2)
import Node.Path (FilePath)

foreign import data Database :: Type

foreign import openDb :: FilePath -> Effect Database

foreign import closeDb :: Database -> Effect Unit

foreign import execImpl :: Fn2 Database String (Effect Unit)

exec :: Database -> String -> Effect Unit
exec = runFn2 execImpl
