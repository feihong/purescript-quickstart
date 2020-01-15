module HelloSqlite where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Sqlite (openDb, exec, closeDb)

main :: Effect Unit
main = do
  db <- openDb "./output.sqlite3"

  exec db """
CREATE TABLE IF NOT EXISTS entry (
  id integer primary key unique,
  traditional text,
  simplified text,
  pinyin text,
  gloss text
)
  """

  closeDb db
