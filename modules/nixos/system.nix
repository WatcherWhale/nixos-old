{ config, lib, pkgs, inputs, ... }:

{
    imports = [
        inputs.home-manager.nixosModules.default
    ];

    nixpkgs.config = {
        allowUnfree = true;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    time.timeZone = "Europe/Brussels";

    sound.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
    };

    users.users.watcherwhale = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "network" "power" "audio" "disk" "input" "kvm" "games" ];
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
    system.activationScripts.binbash = {
        deps = ["binsh"];
        text = ''
            ln -sf /bin/sh /bin/bash
        '';
    };

  programs.gnupg.agent = {
    enable = true;
    enablesshsupport = true;
  };
};
