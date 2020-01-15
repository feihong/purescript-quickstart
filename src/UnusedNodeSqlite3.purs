
module NodeSqlite3 where

import Prelude
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = log "We don't want to use node-sqlite3 library"

{-
import Prelude
import Effect (Effect)
import Effect.Console (log)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import SQLite3 (newDB, closeDB, queryDB)

type Entry =
  { id :: Int
  , traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

main :: Effect Unit
main = launchAff_ do
  let outputFile = "./output.sqlite3"
  db <- newDB outputFile
  _ <- queryDB db
    """
CREATE TABLE IF NOT EXISTS entry (
  id integer primary key unique,
  traditional text,
  simplified text,
  pinyin text,
  gloss text
)
    """ []

  closeDB db

  liftEffect $ log "Done!"
-}
