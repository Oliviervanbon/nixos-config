{ inputs, lib, config, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = true;
      warn-dirty = false;
      trusted-users = [
        "root"
        "@wheel"
      ];
      # TODO: Add trusted-public-keys for remote deployment

      # Disable global flake gegistry as we define all flake inputs as
      # registries below
      flake-registry = "";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d"; # keep last month
      persistent = true; # Should be default
    };

    # Add each flake input as registry
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add each input to legacy channels
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
