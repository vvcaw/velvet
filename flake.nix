{
  description = "velvet's decription";
  inputs = {
    # Change this to the current branch or sth
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    wasi-ghc = {
      url = "git+https://gitlab.haskell.org/ghc/ghc-wasm-meta.git";
      inputs = { };
    };
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, flake-utils, wasi-ghc, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        # This is just how flake-utils generates the outputs
        generatePackageSet = wasi-ghc.packages.x86_64-linux.wasm32-wasi-cabal-gmp;
        overlays = [ ];
        pkgs =
          import nixpkgs { inherit system overlays; config.allowBroken = true; };
        pkgs-unstable = 
          import nixpkgs-unstable { inherit system overlays; config.allowBroken = true; };
        # https://github.com/NixOS/nixpkgs/issues/140774#issuecomment-976899227
        m1MacHsBuildTools =
          pkgs.haskellPackages.override {
            overrides = self: super:
              let
                workaround140774 = hpkg: with pkgs.haskell.lib;
                  overrideCabal hpkg (drv: {
                    enableSeparateBinOutput = false;
                  });
              in
              {
                ghcid = workaround140774 super.ghcid;
                ormolu = workaround140774 super.ormolu;
              };
          };
      in
      {
        # TODO: Add target for package.lock file instead of using `npm i`
        # Used by `nix develop` (dev shell)
        devShell = pkgs.mkShell {
          packages = (with (if system == "aarch64-darwin" then m1MacHsBuildTools else pkgs.haskellPackages); [
            generatePackageSet
            cabal-fmt
            cabal-install
            ghcid
            haskell-language-server
            ormolu
            pkgs.nixpkgs-fmt
            pkgs.watchexec
            pkgs.nodejs
            pkgs-unstable.wizer
          ]);
        };
      });
}
