{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "hello-purescript"
, dependencies =
    [ "aff"
    , "console"
    , "datetime"
    , "effect"
    , "foreign"
    , "functions"
    , "generics-rep"
    , "lazy"
    , "milkis"
    , "node-buffer"
    , "node-child-process"
    , "node-fs"
    , "node-fs-aff"
    , "node-process"
    , "node-readline"
    , "node-streams"
    , "psci-support"
    , "random"
    , "refs"
    , "simple-json"
    , "string-parsers"
    , "strings"
    , "stringutils"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
