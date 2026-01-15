{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		base16.url = "github:SenchoPens/base16.nix";
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations = {
			bertor = nixpkgs.lib.nixosSystem {
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
