{
inputs = {

  # Follow the specified input
  nixpkgs.follows = "nixpkgs-unstable";

  # Nix packages
  nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
  nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  nixos-generators = {
    url = "github:nix-community/nixos-generators";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = { self, nixpkgs, nixpkgs-stable, nixos-generators, ... } @ inputs:
{

  nixosConfigurations = {
  iso = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
        ./iso.nix
        ];
      };
};
};
}
