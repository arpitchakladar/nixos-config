{ config, lib, ... }:
let
  cfg = config.user;
  userNames = map (user: user.username) cfg.users;
in
{
  assertions = [
    {
      assertion = lib.length userNames == lib.length (lib.unique userNames);
      message = ''
        user.users contains duplicate usernames. Each configured user must have a unique
        username because NixOS can create only one account for each login name.
      '';
    }
    {
      assertion = lib.all (user: user.shell != "zsh" || config.tools.zsh.enable) cfg.users;
      message = ''
        At least one user in user.users uses the default zsh shell, but tools.zsh.enable is false.
        Enable tools.zsh or set every affected user's shell to "bash" so their configured
        login shell is installed on the system.
      '';
    }
  ];
}
