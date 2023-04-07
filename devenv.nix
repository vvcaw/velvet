{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ 
    pkgs.git
    pkgs.clang_14
    pkgs.llvmPackages_14.llvm
    pkgs.cairo
    pkgs.emscripten
    pkgs.SDL2
    pkgs.lld_14
  ];

  scripts.build.exec = ''
    export EM_CACHE=`pwd`/.emscripten_cache
    emcc main.cpp -o build/index.html -s USE_SDL=2
  '';

  scripts.serve.exec = ''
    python3 -m http.server
  '';
}
