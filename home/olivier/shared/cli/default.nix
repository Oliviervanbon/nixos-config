{ pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./zsh.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    # Nix tools
    nil # LSP
    nixpkgs-fmt # Formatter

    # Stuff I want in my shell
    # Basic Tooling
    wget
    curl
    nano
    tree
    tldr # simple man
    rsync

    # System Stuff
    bottom # htop alternative
    eza # ls clone
    glances # htop alternative
    jq # JSON shenanigans
    just # justfiles`
    neofetch # system info
    ranger # file browser
    ripgrep # Better grep
    tmux # screen but better
    neovim

    kitty.terminfo # makes SSH'ing from kitty work nicely

    # Development
    micromamba
    micromamba
  ];

  programs = {
    # Better cat (syntax highlighting etc.)
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
  };
}
