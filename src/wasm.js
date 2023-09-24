import { WASI } from "@bjorn3/browser_wasi_shim/dist";
import velvetWasm from "url:./velvet.wasm"

async function run() {
    const wasi = new WASI([], [], []);
    const wasiImportObj = { wasi_snapshot_preview1: wasi.wasiImport };
    const wasm = await WebAssembly.instantiateStreaming(fetch(velvetWasm), wasiImportObj);
    wasi.inst = wasm.instance;
    const exports = wasm.instance.exports;
    const memory = exports.memory;
    const mallocBytes = exports.mallocBytes;
    const encoder = new TextEncoder();
    const decoder = new TextDecoder();

    //const outputPtrPtr = exports.mallocPtr();
    console.log("Initialized WASI reactor.");

    console.log(exports.idInt(10))
}

run();