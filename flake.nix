{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      imports = [inputs.haskell-flake.flakeModule];

      perSystem = {
        self',
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        #  _module.args.pkgs = import inputs.nixpkgs {
        #    inherit system;
        #    overlays = [
        #      (final: prev: {gvc = final.graphviz;})
        #    ];
        #  };

        haskellProjects.default = {};

        packages.default =
          self'.packages.example;

        packages.ordinary =
          pkgs.haskellPackages.callCabal2nix "example" ./. {gvc = pkgs.graphviz;};
      };
    };
}
