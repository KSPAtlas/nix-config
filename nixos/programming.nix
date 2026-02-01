{ config, lib, pkgs, ... }:

{
  # Configure emacs
  services.emacs = {
    package = with pkgs; (
      (emacsPackagesFor emacs-pgtk).emacsWithPackages (
          epkgs: with epkgs; [
            vterm
            doom-themes
            evil

            treemacs
            treemacs-evil
            treemacs-magit
            treemacs-nerd-icons

            magit
            forge
            code-review

            doom-modeline

            haskell-mode
            nix-mode

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
      	    ]))
      	    tree-sitter-langs

            indent-bars
            ligature
            anzu
            evil-anzu
            ultra-scroll
          ]
        )
    );

    enable = true;
  };
}
