let
  common = import ../common.nix { asMailServer = true; };
  emacs = import ../emacs.nix {
    pkgs = common.nixpkgs;
    locals = ./locals.el;
  };

in
{
  nixpkgs.config.nixpkgs.config.allowUnfree = true;

  accounts = common.accounts;

  home.packages =
    common.packages.generic
    ++ [ emacs.derivation ]
    ++ common.packages.nixos
    ++ common.packages.programming
    ++ common.packages.haskell
    ++ common.packages.provers
    ++ common.packages.latex
    ++ common.packages.streaming;

    home.sessionVariables = common.sessionVariables;
    home.file = common.file // emacs.file // {
      ".xmobarrc".source = ../../config/carbon/xmobarrc;
      ".xmonad/xmonad.hs".source = ../../config/xmonad/xmonad.hs;
      ".xmonad/get-mails.sh".source = ../../config/xmonad/get-mails.sh;
      ".xmonad/get-mic.sh".source = ../../config/xmonad/get-mic.sh;
      ".xmonad/get-volume.sh".source = ../../config/xmonad/get-volume.sh;
      ".config/fish/functions/fixUI.fish".source = ../../config/fish/functions/fixUI.fish;
      ".config/fish/functions/m0.fish".source = ../../config/fish/functions/m0.fish;
      ".config/fish/functions/m1.fish".source = ../../config/fish/functions/m1.fish;
      ".config/fish/functions/m2.fish".source = ../../config/fish/functions/m2.fish;
      ".config/fish/functions/rt.fish".source = ../../config/fish/functions/rt.fish;
      ".config/fish/functions/ssh.fish".source = ../../config/fish/functions/ssh.fish;
      ".config/fish/functions/ec.fish".source = ../../config/fish/functions/ec.fish;
      ".config/fish/functions/ed.fish".source = ../../config/fish/functions/ed.fish;
    };

    programs = common.programs // common.helpers.mkKitty {
      "font_size" = "12.0";
    };

    fonts = common.fonts;

    # This suddently stopped working. I don't care enough to investigate.
    services = common.services // {
      picom.enable = true;
      muchsync.remotes = {
        desktop = {
          local.checkForModifiedFiles = true;
          remote = {
            checkForModifiedFiles = true;
            host = "192.168.10.67";
          };
        };
        thelxinoe = {
          local.checkForModifiedFiles = true;
          remote = {
            checkForModifiedFiles = true;
            host = "192.168.1.55";
          };
        };
      };
      # emacs = {
      #   enable = true;
      #   package = emacs.derivation;
      #   client = {
      #     enable = true;
      #     arguments = [ "-c" ];
      #   };
      #   socketActivation.enable = true;
      # };
    };
}
