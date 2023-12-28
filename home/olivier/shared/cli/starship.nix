{ pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 5000;
      time = {
        disabled = false;
        format = "\\\[[$time]($style)\\\]";
      };
      username = {
        disabled = false;
        show_always = true;
      };
      hostname = {
        disabled = false;
        ssh_only = true;
      };
      fill = {
        disabled = false;
        symbol = " ";
      };
      shell = {
        disabled = true;
        zsh_indicator = "zsh";
        bash_indicator = "bsh";
        fish_indicator = "fish";
        format = "[$indicator]($style)";
      };

      line_break.disabled = false;
      cmd_duration.disabled = false;
      nix_shell.disabled = false;
      python.disabled = false;
      conda.disabled = false;
      docker_context.disabled = false;

      # Just disable most stuff
      aws.disabled = true;
      battery.disabled = true;
      crystal.disabled = true;
      dart.disabled = true;
      dotnet.disabled = true;
      elixir.disabled = true;
      elm.disabled = true;
      env_var.disabled = true;
      erlang.disabled = true;
      gcloud.disabled = true;
      golang.disabled = true;
      java.disabled = true;
      jobs.disabled = true;
      julia.disabled = true;
      kubernetes.disabled = true;
      lua.disabled = true;
      memory_usage.disabled = true;
      nim.disabled = true;
      ocaml.disabled = true;
      openstack.disabled = true;
      package.disabled = true;
      perl.disabled = true;
      php.disabled = true;
      purescript.disabled = true;
      ruby.disabled = true;
      rust.disabled = true;
      singularity.disabled = true;
      swift.disabled = true;
      terraform.disabled = true;
      zig.disabled = true;
    };
  };
}
