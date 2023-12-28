{ pkgs, config, ... }: {
  # Basic waybar config
  programs.waybar = {
    enable = true;
    settings.mainbar = {
      layer = "top";
      position = "top";
      height = 16;
      modules-left = [ "wlr/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right =
        [ "pulseaudio" "cpu" "memory" "temperature" "clock" "tray" ];
      "clock" = { format = "{:%Y-%m-%d %H:%M}"; };
      "pulseaudio" = { scroll-step = "5.0"; };
      temperature.thermal-zone = 0;
    };
    systemd.enable = true;
  };
}
