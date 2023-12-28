{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
  };

  # Use Firefox as default for HTML, XML, http://, https://
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
