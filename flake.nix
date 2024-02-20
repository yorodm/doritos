{
  description = "My shells and templates for development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rustTarget = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" ];
          targets = [ "wasm32-wasi" "wasm32-unknown-unknown" ];
        };
        defaultShell =  import ./shells/nix-dev.nix {inherit pkgs; };
      in
      {
        devShells.default = defaultShell;
        devShells.python-dev = import ./shells/python-dev.nix {inherit pkgs;};
        devShells.rust-dev = pkgs.mkShell {
          buildInputs = [
            rustTarget
          ];
        };
      }
    );
}
