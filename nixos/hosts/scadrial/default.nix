{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix

    # Shared core
    ../../shared/core
    ../../shared/users/olivier

    # Shared optional
    # ../../shared/extra/greetd.nix
  ];

  # Networking
  networking = {
    hostName = "scadrial";
  };

  security.polkit.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Bootloader.
  # Note that my /boot is on /dev/sda1, which is the default.
  # So no further config is required there.
  # Also add aarch64 as emulated QEMU system so we can cross-deploy to the Pi
  boot = {
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      kernelModules = [ "nvidia " ];
    };
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "module_blacklist=i915" # blacklist integrated GPU
    ];
    loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  # Due to a difference in handling system clock time in windows, we need to use
  # local time for our system clock instead of UTC (otherwise Windows will be behind)
  time.hardwareClockInLocalTime = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # https://nix-community.github.io/home-manager/index.html#_why_do_i_get_an_error_message_about_literal_ca_desrt_dconf_literal_or_literal_dconf_service_literal
  programs.dconf.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # nix.extraOptions = "secret-key-files = /home/claeff/nix/nix-configs/nixos/hosts/hera/hera-cache-priv-key.pem";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
