{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./zsh.nix
    ./locale.nix
    ./nix.nix
    # ./sops.nix
  ];

  # Needed to pass flake inputs/outputs to home-manager NixOS module
  #  will result in infinite recursion otherwise
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Install the full Terminfo database
  # (disable for now as man-cache takes forever)
  environment.enableAllTerminfo = false;
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];
}
