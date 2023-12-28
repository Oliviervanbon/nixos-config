{ pkgs, inputs, outputs, ... }: {
  imports = [
    ./shared/core
    ./shared/cli
    ./shared/desktop
    ./shared/pass
  ];
}
