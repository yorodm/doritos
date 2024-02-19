{
  description = "My shells and templates for development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        defaultShell =  import ./shells/nix-dev.nix {inherit pkgs; };
      in
      {
        devshells.default = defaultShell;
      }
    );
}
