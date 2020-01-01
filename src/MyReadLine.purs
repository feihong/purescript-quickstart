module MyReadLine
  ( module Exports
  , setCloseHandler
  ) where

import Prelude
import Effect (Effect)
import Node.ReadLine (Interface, InterfaceOptions, LineHandler, close, createInterface, output, setLineHandler) as Exports

-- | Set the current close handler function.
foreign import setCloseHandler :: Exports.Interface -> (Effect Unit) -> Effect Unit
