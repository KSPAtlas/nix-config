{ pkgs, ... }: {
  
programs.nixcord = {
    enable = true;

    vesktop.enable = true;
    config.plugins = {
      betterGifAltText.enable = true;
      betterSessions.enable = true;
      betterUploadButton.enable = true;
      ClearURLs.enable = true;
      experiments.enable = true;
      fakeNitro.enable = true;
      fakeProfileThemes.enable = true;
      fixYoutubeEmbeds.enable = true;
      forceOwnerCrown.enable = true;
      friendsSince.enable = true;
      loadingQuotes.enable = true;
      memberCount.enable = true;
      mentionAvatars.enable = true;
      messageLogger.enable = true;
      iLoveSpam.enable = true;
      ReviewDB.enable = true;
      roleColorEverywhere.enable = true;
      serverInfo.enable = true;
      showHiddenThings.enable = true;
      vencordToolbox.enable = true;
      whoReacted.enable = true;
      youtubeAdblock.enable = true;
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
    kdePackages.kate
    kdePackages.konsole # For kate
    wineWow64Packages.stable
    blender
    godot
    ardour
    lapce
    chromium
  ];
}

