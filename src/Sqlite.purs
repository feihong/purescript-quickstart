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
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Foreign (Foreign)
import Node.Path (FilePath)

foreign import data Database :: Type
foreign import data Statement :: Type

foreign import openDb :: FilePath -> Effect Database

foreign import closeDb :: Database -> Effect Unit

foreign import execImpl :: EffectFn2 Database String Unit

exec :: Database -> String -> Effect Unit
exec = runEffectFn2 execImpl

foreign import prepareImpl :: EffectFn2 Database String Statement

prepare :: Database -> String -> Effect Statement
prepare = runEffectFn2 prepareImpl

foreign import runImpl :: EffectFn2 Statement (Array Foreign) Unit

run :: Statement -> Foreign -> Effect Unit
run statement param = runEffectFn2 runImpl statement [param]

foreign import allImpl :: EffectFn2 Statement (Array Foreign) Foreign

all :: Statement -> Foreign -> Effect Foreign
all statement param = runEffectFn2 allImpl statement [param]

all' :: Statement -> Effect Foreign
all' statement = runEffectFn2 allImpl statement []
