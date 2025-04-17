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
            emacsPackages.magit
            emacsPackages.nix-mode
            git
            gh
            gnumake
            vim
          ];
        };

        formatter = pkgs.nixfmt-tree;
      }
    );
}
