with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "velvet";
    src = ./.;

    buildInputs = [ cmake clang ];
}
