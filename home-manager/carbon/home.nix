let

  common = import ../common.nix;

in
{
  nixpkgs.config.nixpkgs.config.allowUnfree = true;

  accounts = common.accounts;

  home.packages =
    common.packages.generic
    ++ common.packages.nixos
    ++ common.packages.programming
    ++ common.packages.haskell
    ++ common.packages.provers
    ++ common.packages.scala
    ++ common.packages.latex
    ++ common.packages.streaming;

  home.sessionVariables = common.sessionVariables;
  home.file = common.file;

  programs = common.programs // common.helpers.mkKitty {
    "font_size" = "24.0";
  };

  services = common.services;
}
