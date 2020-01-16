module HelloSqlite where

import Prelude
import Effect (Effect)
import Effect.Console (log, logShow)
import Data.Either (Either(..))
import Data.Traversable (for_)
import Sqlite (openDb, exec, prepare, run, all', closeDb)
import Simple.JSON as JSON

type Entry =
  { id :: Int
  , traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

entries :: Array Entry
entries = [
  {
    id: 1,
    traditional: "優美",
    simplified: "优美",
    pinyin: "you1 mei3",
    gloss: "graceful/fine/elegant"
  },
 {
    id: 2,
    traditional: "反問語氣",
    simplified: "反问语气",
    pinyin: "fan3 wen4 yu3 qi4",
    gloss: "tone of one's voice when asking a rhetorical question"
  }
]

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

  for_ entries \entry -> run insertStatement $ JSON.write entry

  selectStatement <- prepare db "SELECT * FROM entry"

  results <- all' selectStatement

  case JSON.read results of
    Left err -> log $ "Error fetching entries: " <> show err
    Right (entries' :: Array Entry) -> for_ entries' \entry -> logShow entry

  closeDb db
