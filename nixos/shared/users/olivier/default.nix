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
    # hashedPassword = "$y$j9T$66xt39VMS7gJxIjY9T8Ed.$n1cR/LITHBJgDMf1slHW5rN8Xg.shRUUxw0SDf/qtP1";
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjrWge7MlGj8KjIiXQ3Tziw6s8FwRBkReLcWXvpv/ej claeff@hera"
    # ];
  };
  home-manager.users.olivier = import ./../../../../home/olivier/${config.networking.hostName}.nix;
}
