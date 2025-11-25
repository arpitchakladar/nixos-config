{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

		base16.url = "github:SenchoPens/base16.nix";

		tt-schemes = {
			url = "github:tinted-theming/schemes";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations."bertor" = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./modules
				./configuration.nix
				inputs.base16.homeManagerModule
				{
					scheme = "${inputs.tt-schemes}/base16/onedark-dark.yaml";
				}
			];
		};
	};
}
