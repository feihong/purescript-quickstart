module HelloSqlite where

import Prelude
import Effect (Effect)
import Effect.Console (logShow)
import Data.Either (Either(..))
import Data.Traversable (for)
import Sqlite (openDb, exec, prepare, run, all', closeDb)
import Simple.JSON as JSON

type Entry =
  { id :: Int
  , traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

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

  insertStatement <- prepare db """
  INSERT OR REPLACE INTO entry VALUES (
    $id, $traditional, $simplified, $pinyin, $gloss
  )
  """

  run insertStatement (JSON.write {
    id: 1,
    traditional: "優美",
    simplified: "优美",
    pinyin: "you1 mei3",
    gloss: "graceful/fine/elegant"
  })

  selectStatement <- prepare db "SELECT * FROM entry"

  entries <- all' selectStatement

  -- case JSON.read entries :: Array Entry of
  --   Left err -> logShow err
  --   Right entries' -> logShow entries

  closeDb db
