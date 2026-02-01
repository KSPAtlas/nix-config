{ pkgs, ... }: {
  
programs.nixcord = {
    enable = true;

    equibop.enable = true;
    config.plugins = {
      anammox.enable = true;
      betterAudioPlayer.enable = true;
      betterGifAltText.enable = true;
      betterUploadButton.enable = true;
      characterCounter.enable = true;
      ClearURLs.enable = true;
      equicordToolbox.enable = true;
      experiments.enable = true;
      fakeNitro.enable = true;
      fixYoutubeEmbeds.enable = true;
      forceOwnerCrown.enable = true;
      gitHubRepos.enable = true;
      holyNotes.enable = true;
      memberCount.enable = true;
    };
  };

  home.file.".emacs".source = ../dotfiles/init.el;
  
  home.packages = with pkgs; [
    lagrange
    thunderbird
    libreoffice-qt6
    qbittorrent
    imv
    prismlauncher
    vlc
    anki
    vscodium
    obsidian
    lutris
    ckan
    krita
    gimp
    lmms
    kdePackages.kate
    wineWowPackages.stable
  ];
}

