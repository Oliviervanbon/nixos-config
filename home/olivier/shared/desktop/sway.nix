{ pkgs, ... }: {
  home = {
    sessionVariables = {

      /*
      Disabled this for now: https://github.com/NixOS/nixpkgs/issues/238416.
      For some reason, VSCode also sometimes crashes on launch with this enabled
      */
      NIXOS_OZONE_WL = "1"; # This should hint to electron apps to use Wayland. (wiki.hyprland.org/Nix)
    };
  };

  # Copied from eisfunke
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true; # enables sway-session.target
    swaynag = {
      enable = true;
      settings = {
        "<config>" = {
          # font = "Raleway 12";
          dismiss-button = "⨯";

          button-border-size = "0";
          border-bottom-size = "0";
          details-border-size = "0";
          button-padding = "6";
          button-gap = "12";
        };

        "warning" = {
          background = "ffff0090";
          button-background = "A2620280";
          text = "ffffffff";
          button-text = "ffffffff";
        };

      };
    };

    config = {
      bars = [{ command = "waybar"; }];
    };
  };
}
