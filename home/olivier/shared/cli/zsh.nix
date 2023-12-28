{ pkgs, ... }: {
  home.sessionVariables = {
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
  };
  programs = {
    bash = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        size = 1000000;
        save = 1000000;
        share = true; # share hsitory between sessions
        ignoreDups = true; # ignores if duplicate of prev command
        expireDuplicatesFirst = true;
        extended = true; # save timestamps
      };
      shellAliases = {
        g = "git";
        cat = "bat";
        grep = "rg"; # ripgrep
        ping = "mtr";
        speed = "speedtest-cli --simple";
        ipe = "curl ipinfo.io/ip && echo";
        ipi = "ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'";
        l = "ls";
        ll = "ls -lAh";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
    };
  };
}
