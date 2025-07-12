{ lib, config, pkgs, ... }:

{
	# Define SDDM theme files
	config = lib.mkIf config.graphical.enable
	(let
		# Fetch the monochrome theme from GitHub
		sddmTheme = (import ./monochrome { inherit pkgs config; });
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

		environment.etc."${pathToThemeDir}/monochrome".source = sddmTheme;

		services.displayManager.sddm.settings.Theme.ThemeDir = "/etc/${pathToThemeDir}";
		services.displayManager.sddm.settings.General.InputMethod = "";
		services.displayManager.sddm.settings.General.GreeterCommand = "${pkgs.libsForQt5.sddm}/bin/sddm-greeter";
		services.displayManager.sddm.theme = "monochrome";
	});
}
