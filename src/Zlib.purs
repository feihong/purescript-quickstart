module Zlib where

import Effect (Effect)
import Node.Stream (Duplex)

foreign import createGzip :: Effect Duplex
foreign import createGunzip :: Effect Duplex
