module ReadJson where

import Prelude
import Data.Either (Either(..))
import Data.Traversable (for_)
import Effect (Effect)
import Effect.Console (logShow)
import Simple.JSON as JSON

type Entry =
  { id :: Int
  , traditional :: String
  , simplified :: String
  , pinyin :: String
  , gloss :: String
  }

json :: String
json = """[
  {
    "id": 1,
    "traditional": "優美",
    "simplified": "优美",
    "pinyin": "you1 mei3",
    "gloss": "graceful/fine/elegant"
  },
  {
    "id": 2,
    "traditional": "反問語氣",
    "simplified": "反问语气",
    "pinyin": "fan3 wen4 yu3 qi4",
    "gloss": "tone of one's voice when asking a rhetorical question"
  }
]"""

main :: Effect Unit
main = do
  case JSON.readJSON json of
    Left err -> logShow err
    Right (entries :: Array Entry) -> for_ entries \entry -> logShow entry
