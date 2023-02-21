{
  description = "Neural Networks from Scratch";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        devShells = flake-utils.lib.flattenTree {
          default = pkgs.mkShell {
            name = "NNFS shell";
            packages = with pkgs; [
              # Used only for scripts/docker-compose-wait.py
              python3Minimal
            ];
            #NIX_LD_LIBRARY_PATH = with pkgs; nixpkgs.lib.makeLibraryPath [
            #  stdenv.cc.cc
            #  openssl
            #];
            #NIX_LD = pkgs.runCommand "ld.so" {} ''
            #  ln -s "$(cat '${pkgs.stdenv.cc}/nix-support/dynamic-linker')" $out
            #'';
          };
        };

      }
    );
}
