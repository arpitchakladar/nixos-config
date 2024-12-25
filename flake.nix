{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		base16.url = "github:SenchoPens/base16.nix";

		tt-schemes = {
			url = "github:tinted-theming/schemes";
			flake = false;
		};

		tuilog = {
			url = "github:arpitchakladar/tuilog";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations."bertor" = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./modules
				./configuration.nix
				inputs.home-manager.nixosModules.default
				inputs.base16.homeManagerModule
				{
					scheme = "${inputs.tt-schemes}/base16/onedark-dark.yaml";
				}
				inputs.tuilog.nixosModules.tuilog
			];
		};
	};
}
