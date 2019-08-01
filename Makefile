NIX_FLAGS=--cores 0 -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/19.03.tar.gz

build:
	nix-build ${NIX_FLAGS} default.nix

shell:
	nix-shell ${NIX_FLAGS} default.nix