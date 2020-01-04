module NodeFile where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Class (liftEffect)
import Data.List.Lazy ((..))
import Data.Foldable (intercalate)
import Effect.Aff (launchAff_)
import Node.FS.Aff (writeTextFile, readTextFile)
import Node.Encoding (Encoding(UTF8))
import Node.ChildProcess (execSync, defaultExecSyncOptions)

content :: String
content = intercalate "\n" lazyLines
  where lazyLines = (\x -> "你好世界" <> show x) <$> (1..8888)

main :: Effect Unit
main = launchAff_ do
  writeTextFile UTF8 "output.txt" content
  liftEffect $ log "Wrote to output.txt"

  text <- readTextFile UTF8 "output.txt"
  liftEffect $ log $ "Contents of output.txt: " <> text

  _ <- liftEffect $ execSync "gzip -k output.txt" defaultExecSyncOptions

  -- Last statement in a do block must be an expression, not a binder
  pure unit
