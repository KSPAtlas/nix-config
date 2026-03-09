{ config, lib, pkgs, ... }:

{
  # Configure emacs
  services.emacs = {
    package = with pkgs; (
      (emacsPackagesFor emacs-pgtk).emacsWithPackages (
          epkgs: with epkgs; [
            vterm # Terminal emulator inside Emacs
            doom-themes # Cool themes

            # File explorer
            treemacs
            treemacs-magit
            treemacs-nerd-icons

            # Git
            magit
            forge
            code-review

            doom-modeline

            haskell-mode
            nix-mode
            zig-mode

            corfu
            cape
            nerd-icons-corfu
            
            lispy
            lispyville
            
      	    flycheck
            flycheck-popup-tip
            package-lint
            
      	    (treesit-grammars.with-grammars (grammars: with grammars; [
      	      tree-sitter-haskell
      	      tree-sitter-nix
      	      tree-sitter-elisp
      	      tree-sitter-json
      	      tree-sitter-markdown
              tree-sitter-zig
      	    ]))
      	    tree-sitter-langs

            indent-bars
            ligature
            anzu
            ultra-scroll
            lsp-mode
            hl-todo
          ]
        )
    );

    enable = true;
  };
}
