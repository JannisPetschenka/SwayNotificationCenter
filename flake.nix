{
  description = "SwayNotificationCenter";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: {
    devShells =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in
      utils.lib.eachDefaultSystemMap (system: {
        # default = pkgs.callPackage ./shell.nix { };
        # TODO
      });

    packages =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in
      utils.lib.eachDefaultSystemMap (system: {
        default = pkgs.callPackage ./build-scripts { };
      });
  };
}
