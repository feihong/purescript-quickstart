-- https://github.com/purescript-node/purescript-node-streams/tree/master/example
module Decompress where

import Prelude

import Effect (Effect)
import Node.Stream (Duplex, Writable, pipe)
import Node.FS.Stream (createReadStream)

foreign import gunzip :: Effect Duplex
foreign import stdout :: Writable ()

main :: Effect (Writable ())
main = do
  rs <- createReadStream "output.txt.gz"
  z <- gunzip
  _ <- rs `pipe` z
  -- Will fail to print out the very last line
  z `pipe` stdout
