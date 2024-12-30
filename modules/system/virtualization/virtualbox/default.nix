{ config, lib, pkgs, ... }:

{
	config =
	let
		VBoxGuest = pkgs.stdenv.mkDerivation rec {
			name = "VBoxGuest";
			src = ./.; # No source code to fetch; we're just creating a script

			buildInputs = with pkgs; [
				xorg.libXt
				xorg.libX11
				wayland
			];

			installPhase = ''
				mkdir -p $out/bin
				cat > $out/bin/VBoxGuest <<EOF
#!/bin/sh
export LD_LIBRARY_PATH=${pkgs.xorg.libXt}/lib:${pkgs.xorg.libX11}/lib:${pkgs.wayland}/lib:$LD_LIBRARY_PATH
echo Starting VBoxClient clipboard
${config.boot.kernelPackages.virtualboxGuestAdditions}/bin/VBoxClient --clipboard
echo Starting VBoxClient VMSVGA
${config.boot.kernelPackages.virtualboxGuestAdditions}/bin/VBoxClient --vmsvga
EOF
				chmod +x $out/bin/VBoxGuest
			'';
		};
	in lib.mkIf
			(
			config.system.virtualization.enable &&
			config.system.virtualization.program
				== "virtualbox"
		) {
		virtualisation.virtualbox.guest.enable = true;
		virtualisation.virtualbox.guest.clipboard = true;
		virtualisation.virtualbox.guest.seamless = true;
		fileSystems."${config.system.virtualization.sharedFolder.directory}" = {
			fsType = "vboxsf";
			device = config.system.virtualization.sharedFolder.device;
			options = [ "rw" "nofail" ];
		};
		services.xserver.videoDrivers = lib.mkForce [ "vboxvideo" "modesetting" ];
		environment.systemPackages = [
			VBoxGuest
		];
	};
}
