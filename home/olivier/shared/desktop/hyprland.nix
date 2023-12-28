{ pkgs, ... }: {
  home = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # This should hint to electron apps to use Wayland. (wiki.hyprland.org/Nix)
    };
  };

  # Following advice in
  # https://old.reddit.com/r/NixOS/comments/137j18j/need_guide_on_installing_hyprland/
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland.override { legacyRenderer = true; };
    systemd.enable = true;
    # X server running under wayland to provide compatibility with native X11 apps.
    xwayland.enable = true;
    enableNvidiaPatches = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
