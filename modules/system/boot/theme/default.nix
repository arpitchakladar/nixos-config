{ pkgs, config, lib, ... }:

{
	options.system.boot.theme = {
		enable = lib.mkEnableOption "Enables grub theme.";
	};

	config = lib.mkIf config.system.boot.theme.enable {
		boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
			pname = "grub-theme";
			version = "v1.0.0"; # Set your version here

			src = ./.;

			installPhase =
			(let
				themeConf = config.scheme {
					template = builtins.readFile ./theme.mustache.txt;
				};
			in
			''
				mkdir -p $out
				mv FiraCodeNerdFont.pf2 $out/FiraCodeNerdFont.pf2
				mv FiraCodeNerdFontLarge.pf2 $out/FiraCodeNerdFontLarge.pf2
				mv FiraCodeNerdFontSmall.pf2 $out/FiraCodeNerdFontSmall.pf2
				cp ${themeConf} $out/theme.txt
				sed -i -e '1ititle-text: "${config.system.networking.host}"\' $out/theme.txt
			'');
		};
	};
}
