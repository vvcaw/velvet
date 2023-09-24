# velvet

## Developing
First, make sure to enter the `nix` environment with all required tools available. To do so, run `nix develop`.

Now run this to automatically recompile the Haskell code to WASM for rapid development
```
watchexec -w app ./bin/build
```