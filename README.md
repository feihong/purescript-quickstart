# Feihong's PureScript Quickstart

## Prerequisites

```
brew install node
npm install -g yarn
```

## Create project

```
mkdir purescript-quickstart && cd purescript-quickstart
yarn add --dev purescript spago
yarn spago init
```

## Commands

Compile and run `src/Main.purs`

    yarn spago run

Compile and run `src/HelloWorld.purs`

    yarn spago run -m HelloWorld

Start the repl

    yarn spago repl

Compile and run `test/Main.purs`

    yarn spago test

Install PureScript package

    yarn spago install random

Pass arguments into program

    yarn spago run -m SomeModule -a 'arg1 arg2 arg3'

## Tips

Run the repl before you start programming. If your program is currently in a non-compiling state, you won't be able to start the repl.

## Links

- [Recommended tooling for PureScript applications in 2019 ](https://discourse.purescript.org/t/recommended-tooling-for-purescript-applications-in-2019/948)
- [Practical Profunctor Lenses & Optics In PureScript](https://thomashoneyman.com/articles/practical-profunctor-lenses-optics/)
- [PureScript Resources](https://purescript-resources.readthedocs.io/en/latest/)
- [Purescript-Jordans-Reference](https://github.com/JordanMartinez/purescript-jordans-reference)
- [Old PureScript Quickstart](https://github.com/feihong/purescript-quickstart-old)
