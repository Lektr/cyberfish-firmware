{ config, pkgs, lib, ... }:
{
  system.stateVersion = "24.11";

  # General system settings
  hardware.enableRedistributableFirmware = true;
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      extra-experimental-features = [ "flakes" "nix-command" ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages;
  };
  users.users.pi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "cyberfish";
  };

  # Connection settings
  networking = {
    hostName = "cyberfish";
    # This is the IP of the computer connecting to the Pi (I will try this later to avoid wifi all together)
    # defaultGateway = "10.10.10.11";
    # nameservers = [ "10.10.10.11" ];
    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [{
        # This is the static IP of the Pi used for connecting to it
        address = "10.10.10.10";
        prefixLength = 24;
      }];
    };
  };
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # Package settings
  environment.systemPackages = with pkgs; [
    git
    neovim
    nano
    python3
  ];
}
