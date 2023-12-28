{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inter
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
}
