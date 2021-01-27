# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "arche"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    haskell.packages.ghc865.ghc
    cachix
    neovim
    haskellPackages.xmobar
    dmenu
    gmrun
    pass passff-host dbus pinentry_gnome transmission-gtk pavucontrol
    xorg.xmodmap xorg.xev firefox
    xdg_utils git
    paprefs
  ];

  fonts.fonts = [ pkgs.nerdfonts ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  programs.dconf.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip pkgs.gutenprint ];

  # Enable sound.
  sound.enable = true;
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  # hardware.video.hidpi.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable the X11 windowing system.

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    monitorSection = ''
      Option "DPMS" "false"
    '';
    serverFlagsSection = ''
      Option "BlankTime" "20"
    '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    desktopManager = {
      plasma5.enable = false;
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
      sessionCommands = ''
	    setxkbmap -option caps:none
	    xmodmap -e "keycode 66 = Multi_key"
	    export XCOMPOSEFILE = /home/vlad/.XCompose
      '';
    };
    layout = "us";
    libinput.enable = true;
  };

  nix.extraOptions = ''
    binary-caches-parallel-connections = 5
  '';

  services.lorri.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", RUN+="${pkgs.xorg.setxkbmap}/bin/setxkbmap -option caps:none"
    ACTION=="add", SUBSYSTEM=="input", RUN+="${pkgs.xorg.xmodmap}/bin/xmodmap -e \"keycode 66 = Multi_key\""
  '';
  services.udev.path = [ pkgs.autorandr pkgs.xorg.xmodmap pkgs.su pkgs.coreutils pkgs.xorg.setxkbmap ];
  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.vlad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
