-- https://github.com/purescript-node/purescript-node-streams/tree/master/example
module Decompress where

import Prelude

import Effect (Effect)
import Node.Stream (Duplex, Readable, Writable, pipe)
import Node.FS.Stream (createReadStream)

foreign import gunzip :: Effect Duplex
-- foreign import stdin :: Readable ()
foreign import stdout :: Writable ()

main :: Effect (Writable ())
main = do
  z <- gunzip
  -- _ <- stdin `pipe` z
  rs <- createReadStream "output.txt.gz"
  _ <- rs `pipe` z
  z `pipe` stdout
