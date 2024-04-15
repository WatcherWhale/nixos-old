{ config, lib, pkgs, inputs, ... }:

{
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

    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                id = 0;
                isDefault = true;
                settings = {
                    "browser.search.defaultenginename" = "Brave";
                    "browser.search.order.1" = "Brave";
                };
                search = {
                    "Brave" = {
                        urls = [{template = "https://search.brave.com?q={searchTerms}"}];
                    };
                };
                userChrome = ''
                #TabsToolbar {
                    display: none;
                }

                #sidebar-header {
                    display: none;
                }
                '';
            };
        };
    };
};
