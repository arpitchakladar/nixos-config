# Flake - NixOS system configuration for bertor
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    base16.url = "github:SenchoPens/base16.nix";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs =
    {
      self,
      nixpkgs,
      devenv,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;
      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {
            git-hooks.hooks = {
              nixfmt.enable = true;
              forbid-hardware-config = {
                enable = true;
                name = "Forbid hardware-configuration.nix";
                entry = "found hardware-configuration.nix in staging! Do not commit this file.";
                language = "fail";
                files = "hardware-configuration\\.nix$";
              };
            };

            packages = [ pkgs.nixd ];
          }
        ];
      };

      nixosConfigurations = {
        bertor = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./modules
            ./hardware-configuration.nix
            ./hosts/bertor.nix
            inputs.base16.homeManagerModule
            {
              scheme = ./assets/onedark-dark.yaml;
            }
          ];
        };
      };
    };
}
