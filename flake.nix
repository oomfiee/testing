{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {

  iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
        ./iso.nix
        ];
        format = "iso";
      };

  };
}
