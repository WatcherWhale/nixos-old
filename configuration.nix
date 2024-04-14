# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "bowhead"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages : with python3Packages; [
      pyautogui 
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # NVidia
  #hardware.nvidia = {
  #  #package = config.boot.kernelPackages.nvidiaPackages.beta;
  #  open = false;
  #  nvidiaSettings = false;
  #  modesetting.enable = true;
  #  powerManagement = {
  #    enable = false;
  #    finegrained = false;
  #  };
  #  prime = {
  #    offload.enable = true;
  #  };
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver = {
    libinput.enable = true;
    #autorun = false;
    #exportConfiguration = true;
    #displayManager.startx.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.watcherwhale = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "network" "power" "audio" "disk" "input" "kvm" "games" ]; 
    packages = with pkgs; [
      firefox
      tree
      starship
      ranger
      colorls
      direnv
      gum
      bat
      mypy
      zellij
      rofi
      picom
      haskellPackages.greenclip
      kubeswitch
      k9s
      kubectl
      dunst
      mpv
      gimp
      zathura
      nitrogen
      tldr
      trash-cli
      go
      nodejs
    ];

  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    vim
    neovim
    curl
    stow
    alacritty
    fish
    git
    zoxide
    fzf
    autorandr
    phinger-cursors
    lxappearance
    nordic
    flat-remix-icon-theme
    pavucontrol
    xfce.thunar
    xfce.thunar-archive-plugin
    jq
    yq
    acpi
    killall
    htop
    unzip
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code-nerdfont
  ];

  system.activationScripts.binbash = {
    deps = ["binsh"];
    text = ''
      ln -sf /bin/sh /bin/bash
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.openssh.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = ["gtk"];

  services = {
    ntp.enable = true;
    blueman.enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

