{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    base16.url = "github:SenchoPens/base16.nix";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

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
