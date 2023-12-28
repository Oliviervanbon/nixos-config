{ inputs, outputs, lib, pkgs, config, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nix-index-database.hmModules.nix-index
  ];

  nixpkgs = {
    #overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ ];
    };
  };

  # Better reloading of services (https://gitlab.com/rycee/sd-switch)
  systemd.user.startServices = "sd-switch";

  # Few default programs I always want.
  programs = {
    nix-index.enable = true;
    home-manager.enable = true;
    git.enable = true;
  };

  # Default home settings
  home = {
    username = lib.mkDefault "olivier";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    # This adds ~/.local/bin to the PATH
    sessionPath = [ "$HOME/.local/bin" ];
    file.".colorscheme".text = config.colorScheme.slug;
  };

  colorScheme = lib.mkDefault inputs.nix-colors.colorSchemes.onedark;
}
