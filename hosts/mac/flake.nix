{
  description = "Javi's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    {
      darwinConfigurations.macbook = inputs.nix-darwin.lib.darwinSystem {
        # Use x86_64-darwin instead for an Intel Mac.
        system = "aarch64-darwin";

        specialArgs = {
          inherit inputs;
        };

        modules = [
          inputs.home-manager.darwinModules.home-manager
          inputs.stylix.darwinModules.stylix
          ./default.nix
        ];
      };
    };
}
