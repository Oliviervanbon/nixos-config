{
  description = "Redyf's NixOS config for desktop, laptop and WSL";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/hyprland";
    # waybar-hyprland.url = "github:hyprwm/hyprland";
    # xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    # nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{self, nixpkgs, hyprland, home-manager, ...}:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];

      # Function that creates an attribute set with system string as key and
      # the result of a function taking the system as argument
      forAllSystems = lib.genAttrs systems;

      # Function that creates and attribute set with system string a key and
      # takes a function which is called for each system, taking
      # pkgs for that system as argument
      pkgsForEachSystem = func: forAllSystems (system: func pkgsForSystem.${system});

      # Attribute set with <system>:<pkgs> where pkgs has allowUnfree
      # and added overlays
      pkgsForSystem = forAllSystems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

    in
    {

      #overlays = import ./overlays { inherit inputs outputs; };
      #packages = pkgsForEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      #devShells = pkgsForEachSystem (pkgs: import ./shell.nix { inherit inputs pkgs; });
      #formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        ## Laptop Zbook
        #roshar = lib.nixosSystem {
        #  specialArgs = { inherit inputs outputs; };
        #  modules = [ ./nixos/hosts/roshar ];
        #};
        # Oude laptop van Anna NixOS Dual Boot
        scadrial = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos/hosts/scadrial ];
        };
        ## Raspberry Pi 3B
        #sel = lib.nixosSystem {
        #  specialArgs = { inherit inputs outputs; };
        #  modules = [ ./nixos/hosts/sel ];
        #};
      };

      homeConfigurations = {
        #"olivier@roshar" = lib.homeManagerConfiguration {
        #  modules = [ ./home/roshar/roshar.nix ];
        #  pkgs = pkgsForSystem.x86_64-linux;
        #  extraSpecialArgs = { inherit inputs outputs; };
        #};
        "olivier@scadrial" = lib.homeManagerConfiguration {
          modules = [ ./home/olivier/scadrial.nix ];
          pkgs = pkgsForSystem.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        #"olivier@sel" = lib.homeManagerConfiguration {
        #  modules = [ ./home/sel/sel.nix ];
        #  pkgs = pkgsForSystem.aarch64-linux;
        #  extraSpecialArgs = { inherit inputs outputs; };
        #};
      };
    };
}
