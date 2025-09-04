{ config, lib, pkgs, ... }:

{
  programs.adb.enable = true;


  # Configure emacs
  services.emacs = {
    package = with pkgs; (
      (emacsPackagesFor emacs-pgtk).emacsWithPackages (
          epkgs: [
            epkgs.vterm
          ]
        )
    );

    enable = true;
  };
}
