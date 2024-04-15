{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
        bowhead = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
              inputs.home-manager.nixosModules.default
              ./hosts/bowhead/configuration.nix
            ];
        };
    };
  };
}
