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

  # Compile commands are only exported correctly if you don't use emcmake
  scripts.setup.exec = ''
    export EM_CACHE=$DEVENV_ROOT/.emscripten_cache
    mkdir -p $DEVENV_ROOT/build
    cmake -B build -S $DEVENV_ROOT -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  '';

  scripts.build.exec = ''
    emcmake cmake -B build -S $DEVENV_ROOT
    make -C $DEVENV_ROOT/build
  '';

  scripts.serve.exec = ''
    python3 -m http.server
  '';
}
