{ config, ... }:
{
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="feed", ATTRS{idProduct}=="6536", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
}
