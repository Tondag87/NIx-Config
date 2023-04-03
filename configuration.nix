{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    gfxmodeEfi = "1920x1080";
    useOSProber = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };
  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  nixpkgs = {
    config = {
    	permittedInsecurePackages = [
    		"python-2.7.18.6"
    	];
	packageOverrides = pkgs: {
		nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      		inherit pkgs;
    		};
	};
        allowUnfree = true;
    };
  };  


  services = {
    xserver = {
	enable = true;
    	layout = "us";
    	xkbVariant = "";
    	displayManager.gdm.enable = true;
    	desktopManager.gnome.enable = true;
    	windowManager.bspwm.enable = true;
    	videoDrivers = [ "amdgpu" "radeon" ];
    };
    flatpak = {
    	enable = true;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
    opengl.driSupport = true;
  };

  programs = {
   zsh.enable = true;
   steam.enable = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fonts.fonts = with pkgs; [
	nerdfonts
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
    	LC_ADDRESS = "en_US.UTF-8";
 	LC_IDENTIFICATION = "en_US.UTF-8";
    	LC_MEASUREMENT = "en_US.UTF-8";
    	LC_MONETARY = "en_US.UTF-8";
    	LC_NAME = "en_US.UTF-8";
    	LC_NUMERIC = "en_US.UTF-8";
    	LC_PAPER = "en_US.UTF-8";
    	LC_TELEPHONE = "en_US.UTF-8";
    	LC_TIME = "en_US.UTF-8";
    };
  };
 

  users.users.wick3d = {
    isNormalUser = true;
    description = "Anthony Abaray";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
  environment.systemPackages = with pkgs; [
    wget
    neovim
    neofetch
    brave
    tmux
    git
    feh
    nur.repos.reedrw.picom-next-ibhagwan
    bspwm
    sxhkd
    kitty
    zsh
    polybar
    rofi
    ranger
    pavucontrol
    killall
    xclip
    lxappearance
    unzip
    bitwarden
    gcc
    xfce.thunar
    caffeine-ng
    betterlockscreen
    dunst
    exa
    playerctl
    spotify
    btop
    pamixer
    scrot
    libnotify
    nodejs
    python
    nodePackages.pyright
    nodePackages.vscode-langservers-extracted
    lutris
    libdrm
    libratbag
    piper
  ];

  nix = {
   settings = {
   	auto-optimise-store = true;
   	experimental-features = [ "nix-command" "flakes" ];
   };
   gc = {
   	automatic = true;
   	dates = "weekly";
   	options = "--delete-older-than 30d";
   };
  };

  system = {
  autoUpgrade.enable = true;
  stateVersion = "23.05"; 
  };
}
