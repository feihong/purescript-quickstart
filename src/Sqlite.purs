module Sqlite
  ( Database
  , Statement
  , openDb
  , closeDb
  , exec
  , prepare
  , run
  , all
  , all'
  ) where

import Prelude
import Effect (Effect)
import Data.Function.Uncurried (Fn2, runFn2)
import Foreign (Foreign)
import Node.Path (FilePath)

foreign import data Database :: Type
foreign import data Statement :: Type

foreign import openDb :: FilePath -> Effect Database

foreign import closeDb :: Database -> Effect Unit

foreign import execImpl :: Fn2 Database String (Effect Unit)

exec :: Database -> String -> Effect Unit
exec = runFn2 execImpl

foreign import prepareImpl :: Fn2 Database String (Effect Statement)

prepare :: Database -> String -> Effect Statement
prepare = runFn2 prepareImpl

foreign import runImpl :: Fn2 Statement (Array Foreign) (Effect Unit)

run :: Statement -> Foreign -> Effect Unit
run statement param = runFn2 runImpl statement [param]

foreign import allImpl :: Fn2 Statement (Array Foreign) (Effect Foreign)

all :: Statement -> Foreign -> Effect Foreign
all statement param = runFn2 allImpl statement [param]

all' :: Statement -> Effect Foreign
all' statement = runFn2 allImpl statement []
