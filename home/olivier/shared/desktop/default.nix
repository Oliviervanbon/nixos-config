{ pkgs, ... }: {
  imports = [
    ./gtkqt.nix
    ./hyprland.nix
    ./firefox.nix
    ./font.nix
    ./kitty.nix
    # ./obsidian.nix
    ./swaylock.nix
    # ./vscode.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    xdg-utils  # xdg-open and such
  ];
}
