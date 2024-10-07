{ lib, config, pkgs, ... }:

{
	options.display-server.sddm = {
		enable = lib.mkEnableOption "Enable sddm display manager.";
		theme = lib.mkOption {
			type = lib.types.nullOr (lib.types.enum [
				"monochrome"
			]);
			default = null;
			description = "SDDM theme to use.";
		};
	};

	# Define SDDM theme files
	config = lib.mkIf config.display-server.sddm.enable
	(let
		# Fetch the monochrome theme from GitHub
		sddmTheme =
			if config.display-server.sddm.theme == "monochrome" then
				import ./monochrome { inherit pkgs config; }
			else null;
		pathToThemeDir = "sddm/themes";
	in {
		services.displayManager.sddm.enable = true;
		services.desktopManager.plasma6.enable = true;

		environment.etc."${pathToThemeDir}/${config.display-server.sddm.theme}".source = sddmTheme;

		services.displayManager.sddm.settings.Theme.ThemeDir = "/etc/${pathToThemeDir}";
		services.displayManager.sddm.settings.General.InputMethod = "";
		services.displayManager.sddm.theme = config.display-server.sddm.theme;
	});
}
