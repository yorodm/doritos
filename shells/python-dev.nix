{pkgs}:
with pkgs;
  mkShell {
    buildInputs = [
      stdenv # we need this for building some python packages
      python312
      pdm
    ];
  }
