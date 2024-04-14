{ config, lib, pkgs, inputs, ... }:

{
    users.users.watcherwhale = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "network" "power" "audio" "disk" "input" "kvm" "games" ];
    };
};
