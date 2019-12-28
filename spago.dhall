{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
    [ "aff"
    , "console"
    , "datetime"
    , "effect"
    , "node-buffer"
    , "node-fs"
    , "node-fs-aff"
    , "node-streams"
    , "psci-support"
    , "random"
    , "strings"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
