{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    opam-repository = {
      url = "github:ocaml/opam-repository";
      flake = false;
    };
    opam-nix = {
      url = "github:tweag/opam-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        opam-repository.follows = "opam-repository";
      };
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      opam-repository,
      opam-nix,
    }:
    # Don't forget to put the package name instead of `throw':
    let
      package = "myproject";
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        on = opam-nix.lib.${system};
        localPackagesQuery = builtins.mapAttrs (_: pkgs.lib.last) (on.listRepo (on.makeOpamRepo ./.));
        devPackagesQuery = {
          # You can add "development" packages here. They will get added to the devShell automatically.
          ocaml-lsp-server = "*";
          ocamlformat = "*";
          utop = "2.15.0";
        };
        repos = [ opam-repository ];
        query = devPackagesQuery // {
          ocaml-base-compiler = "5.3.0";
          ocamlfind = "1.9.6";
        };
        scope = on.buildOpamProject' { inherit repos; } ./. query;
        overlay = final: prev: {
          # You can add overrides here
          # ${package} = prev.${package}.overrideAttrs (_: {
          #   # Prevent the ocaml dependencies from leaking into dependent environments
          #   doNixSupport = false;
          # });
        };
        scope' = scope.overrideScope overlay;
        # The main package containing the executable
        # main = scope'.${package};
        # de
        # Packages from devPackagesQuery
        devPackages = builtins.attrValues (pkgs.lib.getAttrs (builtins.attrNames devPackagesQuery) scope');
        packages = pkgs.lib.getAttrs (builtins.attrNames localPackagesQuery) scope';
      in
      {
        legacyPackages = scope';

        packages = packages;

        devShells.default = pkgs.mkShell {
          inputsFrom = builtins.attrValues packages;
          buildInputs = devPackages ++ [
            pkgs.nodejs_latest
            # You can add packages from nixpkgs here
          ];
        };
      }
    );
}
