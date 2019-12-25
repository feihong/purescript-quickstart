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

Compile and run `test/Main.purs`

    yarn spago test

Install PureScript package

    yarn spago install random

## Links

- [Recommended tooling for PureScript applications in 2019 ](https://discourse.purescript.org/t/recommended-tooling-for-purescript-applications-in-2019/948)
- [Old PureScript Quickstart](https://github.com/feihong/purescript-quickstart-old)
