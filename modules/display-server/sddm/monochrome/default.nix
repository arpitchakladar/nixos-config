{ pkgs, config }:

pkgs.stdenv.mkDerivation {
	pname = "monochrome";
	version = "v1.1.0"; # Set your version here

	src = ./.;

	installPhase =
	(let
		themeConf = config.scheme {
			template = builtins.readFile ./theme.mustache.conf;
		};
	in ''
		mkdir -p $out
		mv ./Components $out/Components
		mv ./icons $out/icons
		mv Main.qml $out/Main.qml
		mv metadata.desktop $out/metadata.desktop
		cp ${../../../../assets/sapling.png} $out/background.png
		cp ${themeConf} $out/theme.conf
	'');
}
