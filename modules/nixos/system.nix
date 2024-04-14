{ config, lib, pkgs, inputs, ... }:

{
    imports = [
        inputs.home-manager.nixosModules.default
    ];

    nixpkgs.config = {
        allowUnfree = true;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true;

    sound.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
    };

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

    # Fix shebangs
    system.activationScripts.binbash = {
        deps = ["binsh"];
        text = ''
            ln -sf /bin/sh /bin/bash
            ln -sf /bin/sh /usr/bin/bash
        '';
    };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = ["gtk"];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    ntp.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
    printing.enable = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.enable = true;







  # DO NOT TOUCH !!!!!!
  system.stateVersion = "23.11"; # Did you read the comment?
};
