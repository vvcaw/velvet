#!/usr/bin/env bash
WDIR="."

wasm32-wasi-cabal build exe:velvet
wasm32-wasi-cabal list-bin exe:velvet
VELVET_WASM="$(wasm32-wasi-cabal list-bin exe:velvet)"

echo "Running wizer"

wizer \
    --allow-wasi --wasm-bulk-memory true \
    "$VELVET_WASM" -o "$WDIR/velvet-init.wasm"

echo "Done wizer"

if [ $# -eq 0 ]; then
    VELVET_WASM_OPT="$WDIR/velvet-init.wasm"
else
    VELVET_WASM_OPT="$WDIR/velvet-opt.wasm"
    wasm-opt "$@" "$WDIR/velvet-init.wasm" -o "$VELVET_WASM_OPT"
fi

mv "$VELVET_WASM_OPT" src/velvet.wasm
