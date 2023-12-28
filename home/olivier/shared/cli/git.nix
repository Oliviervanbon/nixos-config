{ pkgs, lib, ... }: {
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = lib.mkDefault "Olivier van Bon";
      userEmail = lib.mkDefault "olivier.van.bon@outlook.com";
      aliases = {
        st = "status";
        br = "branch";
        co = "commit";
        cm = "commit -m";
        lg = "log --abbrev-commit --decorate --format=format:'%C(blue)%h%C(reset) - %C(green)(%as)%C(reset) %s %C(#aaaaaa italic)- %an%C(reset)%C(cyan bold)%d%C(reset)' -30";
        unstage = "reset HEAD --";
      };
      ignores = [
        ".idea"
        ".direnv"
      ];
      extraConfig = {
        core = {
          autocrlf = "input";
          editor = "nvim";
        };
        credential.helper = "${pkgs.gitAndTools.gitFull}/bin/git-credential-libsecret";
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
    gh = {
      enable = true;
    };
  };
}
