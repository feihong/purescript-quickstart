module DbSqlite where

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

--   _ <- queryDB db
--     """
-- INSERT INTO entry (id, traditional, simplified, pinyin, gloss) VALUES (
--   $id, $traditional, $simplified, $pinyin, $gloss
-- )
--     """ []

  closeDB db

  liftEffect $ log "Done!"

