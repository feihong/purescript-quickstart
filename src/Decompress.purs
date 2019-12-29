-- https://github.com/purescript-node/purescript-node-streams/tree/master/example
module Decompress where

import Prelude

import Effect (Effect)
import Node.Stream (Writable, pipe)
import Node.FS.Stream (createReadStream)
import Node.Process (stdout)

import Zlib (createGunzip)

main :: Effect (Writable ())
main = do
  rs <- createReadStream "output.txt.gz"
  z <- createGunzip
  -- Ignore return value
  _ <- rs `pipe` z
  -- Will fail to print out the very last line
  z `pipe` stdout
