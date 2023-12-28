{ pkgs, config, ... }:

{
  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.olivier = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Olivier";
    extraGroups = [ "wheel" ];
    packages = [ pkgs.home-manager ];
    # openssh.authorizedKeys.keys = [];
    hashedPassword = "$6$JIcr3UEuvJoP1Mxc$Ljanma2TA8lGmB8cbqJ7BnHgCJNPFWxeXLrMEhFiHbxUCt5XQCxO5k3S.IOHg5i2WXE7PrDl5egsR7/dRGUpD.";
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjrWge7MlGj8KjIiXQ3Tziw6s8FwRBkReLcWXvpv/ej claeff@hera"
    # ];
  };
  home-manager.users.olivier = import ./../../../../home/olivier/${config.networking.hostName}.nix;
}
