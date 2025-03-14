{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
  {
    nixosConfigurations = {
      cyberfish = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-3
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix"
          ./configuration.nix
        ];
      };
    };
    # Set default build to create SD image
    packages.aarch64-linux.default = self.nixosConfigurations.cyberfish.config.system.build.sdImage;
  };
}
