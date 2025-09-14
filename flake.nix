{
  description = "Personal nix monorepo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            emacs
            emacsPackages.go-mode
            emacsPackages.magit
            emacsPackages.markdown-mode
            emacsPackages.nix-mode
            gh
            git
            gnumake
            go
            vim
          ];
        };

        # Pending https://github.com/NixOS/nixpkgs/pull/442968
        packages.nvi = pkgs.callPackage ./pkgs/nvi/package.nix { };

        formatter = pkgs.nixfmt-tree;
      }
    );
}
