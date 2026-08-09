# User - Adaptive local user account configuration
{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.user;
  enabledGroupNames =
    user:
    lib.optionals user.wheel [ "wheel" ]
    ++ lib.optionals user.groups.audio.enable [ "audio" ]
    ++ lib.optionals user.groups.video.enable [ "video" ]
    ++ lib.optionals user.groups.input.enable [ "input" ]
    ++ lib.optionals user.groups.uinput.enable [ "uinput" ]
    ++ lib.optionals user.groups.gamemode.enable [ "gamemode" ]
    ++ lib.optionals user.groups.libvirt.enable [
      "libvirtd"
      "kvm"
    ];
in
{
  imports = [ ./assertions.nix ];

  options.user.users = lib.mkOption {
    type = lib.types.listOf (
      lib.types.submodule (
        { ... }: {
          options = {
            username = lib.mkOption {
              type = lib.types.str;
              description = "Login name for this local user account.";
            };
            description = lib.mkOption {
              type = lib.types.str;
              default = "";
              description = "Optional descriptive text shown by user-management tools.";
            };
            shell = lib.mkOption {
              type = lib.types.enum [
                "zsh"
                "bash"
              ];
              default = "zsh";
              description = "Login shell. Zsh is the default; selecting it requires tools.zsh.enable.";
            };
            initialPassword = lib.mkOption {
              type = lib.types.str;
              default = "nixos";
              description = "Initial password for a newly created account; replace this default before deploying a shared system.";
            };
            wheel = lib.mkEnableOption "sudo access through the wheel group";
            isTrustedUser = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Allow this user to perform trusted Nix operations without a daemon confirmation.";
            };
            groups = lib.mkOption {
              default = { };
              description = "Opt-in system groups that grant access to corresponding host capabilities.";
              type = lib.types.submodule {
                options = {
                  audio.enable = lib.mkEnableOption "membership of the audio group";
                  video.enable = lib.mkEnableOption "membership of the video group";
                  input.enable = lib.mkEnableOption "membership of the input group";
                  uinput.enable = lib.mkEnableOption "membership of the uinput group";
                  gamemode.enable = lib.mkEnableOption "membership of the gamemode group";
                  libvirt.enable = lib.mkEnableOption "membership of the libvirtd and kvm groups";
                };
              };
            };
            extraGroups = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              description = "Additional group names for services not modeled by this module.";
            };
          };
        }
      )
    );
    default = [ ];
    description = "Local normal-user accounts to create.";
  };

  config = {
    users.users = lib.listToAttrs (
      map (user: {
        name = user.username;
        value = {
          isNormalUser = true;
          inherit (user) description initialPassword;
          shell = if user.shell == "zsh" then pkgs.zsh else pkgs.bash;
          extraGroups = lib.unique (enabledGroupNames user ++ user.extraGroups);
        };
      }) cfg.users
    );

    nix.settings.trusted-users = [
      "root"
    ]
    ++ (map (user: user.username) (lib.filter (user: user.isTrustedUser) cfg.users));
  };
}
