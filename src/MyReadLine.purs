module MyReadLine
  ( module Exports
  , onClose
  ) where

import Prelude
import Effect (Effect)
import Node.ReadLine (Interface, InterfaceOptions, LineHandler, close, createInterface, output, setLineHandler) as Exports

-- | Set the current close handler function.
foreign import onClose :: Exports.Interface -> (Effect Unit) -> Effect Unit
