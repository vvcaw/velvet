import WasiContext from "https://deno.land/std/wasi/snapshot_preview1.ts";

const context = new WasiContext({});

const instance = (
  await WebAssembly.instantiate(await Deno.readFile("src/velvet.wasm"), {
    wasi_snapshot_preview1: context.exports,
  })
).instance;

// The initialize() method will call the module's _initialize export
// under the hood. This is only true for the wasi implementation used
// in this example! If you're using another wasi implementation, do
// read its source code to figure out whether you need to manually
// call the module's _initialize export!
context.initialize(instance);

// This function is a part of GHC's RTS API. It must be called before
// any other exported Haskell functions are called.
instance.exports.hs_init(0, 0);

const malloced = instance.exports.malloc(10);
instance.exports.writeByte(malloced, 187);
instance.exports.readByte(malloced);

instance.exports.free(malloced);

console.log(instance.exports.fib(10));

