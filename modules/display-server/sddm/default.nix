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
		services.displayManager.sddm.package = pkgs.libsForQt5.sddm;

		services.displayManager.sddm.extraPackages = with pkgs.libsForQt5.qt5; [
			qtbase
			qtsvg
			qtgraphicaleffects
			qtquickcontrols2
		];

		environment.etc."${pathToThemeDir}/${config.display-server.sddm.theme}".source = sddmTheme;

		services.displayManager.sddm.settings.Theme.ThemeDir = "/etc/${pathToThemeDir}";
		services.displayManager.sddm.settings.General.InputMethod = "";
		services.displayManager.sddm.settings.General.GreeterCommand = "${pkgs.libsForQt5.sddm}/bin/sddm-greeter";
		services.displayManager.sddm.theme = config.display-server.sddm.theme;
	});
}
