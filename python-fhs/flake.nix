{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    fhs = pkgs.buildFHSUserEnv {
      name = "python-fhs";
      targetPkgs = pkgs: (with pkgs.python311Packages; with pkgs;[ 
        python3
        poetry
      ]);
    };
  in
    {
      devShells.${system}.default = fhs.env;
    };
}
