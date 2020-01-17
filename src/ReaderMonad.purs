-- http://adit.io/posts/2013-06-10-three-useful-monads.html
module ReaderMonad where

import Prelude
import Effect (Effect)
import Effect.Console (log)
-- import Control.Monad.Reader (Reader, runReader, ask)

main :: Effect Unit
main = do
  log "woo"
