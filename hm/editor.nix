{ lib, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkForce "monokai";

      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      # keys.insert = {          
      #   up = "no_op";
      #   down = "no_op";
      #   left = "no_op";
      #   right = "no_op";
      #   pageup = "no_op";
      #   pagedown = "no_op";
      #   home = "no_op";
      #   end = "no_op";
      # };
    };

    languages = {
      language = [
        {
          name = "nix";
          language-servers = [ "nixd" "nil" ];
        }
        {
          name = "scheme";
          language-servers = [ "scheme-langserver" ];
        }
      ];

      language-server = {
        nixd.command = "nixd";
        scheme-langserver.command = "scheme-langserver";
        haskell-language-server = {
          command = "haskell-language-server-wrapper";
          args = ["--lsp"];
          timeout = 45;
        };
      };
    }; 
  };
}
