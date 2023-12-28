{ pkgs, ... }:
let
  cursorSettings = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
  };
  gtkExtraConfig = {
    gtk-application-prefer-dark-theme = true;
    gtk-cursor-theme-size = cursorSettings.size;
    gtk-cursor-theme-name = cursorSettings.name;
  };

in
rec {
  home.pointerCursor = cursorSettings // {
    gtk.enable = true;
    x11.enable = true;
  };

  # Set GTK applications theming (And GTK theme for QT)
  gtk = {
    enable = true;
    cursorTheme = cursorSettings;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk2 = {
      extraConfig = ''
        gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-size = ${toString cursorSettings.size}
        gtk-cursor-theme-name = ${cursorSettings.name}
      '';
    };
    gtk3.extraConfig = gtkExtraConfig;
    gtk4.extraConfig = gtkExtraConfig;
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  # TODO: Figure out if required/what it does
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
