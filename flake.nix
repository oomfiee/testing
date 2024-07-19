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


outputs = { self, nixpkgs, nixpkgs-stable, nixos-generators, ... } @ inputs:
  let

    system = "x86_64-linux"; # system arch

    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    in {

  iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
        ./Hosts/isoimage
        ];
        format = "iso";
      };
};
}
