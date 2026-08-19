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
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
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
