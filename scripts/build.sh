#!/usr/bin/env bash
wasm32-wasi-cabal build exe:velvet
wasm32-wasi-cabal list-bin exe:velvet
VELVET_WASM="$(wasm32-wasi-cabal list-bin exe:velvet)"

cp "$VELVET_WASM" src/velvet.wasm
