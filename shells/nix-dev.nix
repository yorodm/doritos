{pkgs}:
with pkgs;
  mkShell {
    buildInputs = [
      nil
      alejandra
    ];
  }
