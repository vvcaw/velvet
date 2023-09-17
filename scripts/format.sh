#!/usr/bin/env bash
find app -name \*.hs | xargs ormolu --mode inplace
nixpkgs-fmt *.nix
cabal-fmt -i *.cabal