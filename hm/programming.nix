{ pkgs, ... }: {
  home.packages = with pkgs; [ 
    racket

    python314
    python314Packages.python-lsp-server
    
    zig
    zls

    nixd
    
    idris2
    idris2Packages.idris2Lsp

    ghc
    haskell-language-server
  ];

  # Enable pretty printing in GHCi
  home.file.".ghci".source = ../dotfiles/ghci.conf;
}
