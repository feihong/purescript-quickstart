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

### Primary

- [Recommended tooling for PureScript applications in 2019 ](https://discourse.purescript.org/t/recommended-tooling-for-purescript-applications-in-2019/948)
- [Purescript-Jordans-Reference](https://github.com/JordanMartinez/purescript-jordans-reference)
- [PureScript Resources](https://purescript-resources.readthedocs.io/en/latest/)
- [PureScript by Example](https://leanpub.com/purescript)
- [Practical Profunctor Lenses & Optics In PureScript](https://thomashoneyman.com/articles/practical-profunctor-lenses-optics/)

### Related

- [Lenses for the Mere Mortal: PureScript Edition](https://leanpub.com/lenses)
- [The ReaderT Design Pattern](https://www.fpcomplete.com/blog/2017/06/readert-design-pattern)
- [purescript-run](https://github.com/natefaubion/purescript-run)
- [Thinking with Types](https://leanpub.com/thinking-with-types)
- [Old PureScript Quickstart](https://github.com/feihong/purescript-quickstart-old)
