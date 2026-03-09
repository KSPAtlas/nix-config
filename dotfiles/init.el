;; Only use packages from nix!
(setq package-archives nil)

;; Disable bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Enable theme & font
(load-theme 'doom-molokai t)
(set-face-attribute 'default t :font "Jetbrains Mono" :height 120)

;; Set up Lispy
(add-hook 'emacs-lisp-mode-hook #'lispy-mode)
(add-hook 'lisp-mode-hook #'lispy-mode)
(add-hook 'lispy-mode-hook #'lispyville-mode)

;; Load Doom-Modeline
(doom-modeline-mode 1)
(anzu-mode 1)

(setq doom-modeline-height 25)

;; Start LSP
(lsp-mode 1)
