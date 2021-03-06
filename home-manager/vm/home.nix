let
  common = import ../common.nix;
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
      ".config/fish/functions/ssh.fish".source = ../../config/fish/functions/ssh.fish;
    };

  programs = common.programs;

  services = common.services;
}
