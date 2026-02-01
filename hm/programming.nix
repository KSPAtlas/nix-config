{ pkgs, ... }: {
  home.packages = with pkgs; [ 
    zls
    nixd
    python315PackagesPackages.python-lsp-server
    racket
    idris2
    idris2Packages.idris2Lsp
    python314
    zig
  ];
}
