{
  description = "sysdiag — system diagnostic TUI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        name = "sysdiag";
        src = ./.;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        installPhase = ''
          mkdir -p $out/bin
          cp sysdiag $out/bin/sysdiag
          chmod +x $out/bin/sysdiag
          wrapProgram $out/bin/sysdiag \
            --prefix PATH : ${pkgs.lib.makeBinPath (with pkgs; [ smartmontools ldns iptables ])}
        '';
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ python3 smartmontools ldns iptables ];
      };
    });
}
