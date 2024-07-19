{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {

    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

  nixpkgs.hostPlatform = "x86_64-linux";

  default = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
        ./iso.nix
        ];
        format = "iso";
      };
  };
}
