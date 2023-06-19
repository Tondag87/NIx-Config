{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
    	grub = {
    	  device = "nodev";
    	  efiSupport = true;
    	  gfxmodeEfi = "1920x1080";
    	  useOSProber = true;
        };
	efi = {
	  canTouchEfiVariables = true;
	  efiSysMountPoint = "/boot";
	};
    };
    initrd = {
    	kernelModules = [ "amdgpu" ];
    };
    supportedFilesystems = [ "ntfs" ];
  };

  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  nixpkgs = {
    config = {
	permittedInsecurePackages = [ "python-2.7.18.6" ];
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
      displayManager.gdm.wayland = true;
      desktopManager.gnome.enable = true;
    	videoDrivers = [ "amdgpu" "radeon" ];
    };
    pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    };
    flatpak = {
    	enable = true;
    };
  };
  xdg = {
    portal = {
      enable = true;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
    pulseaudio.enable = false;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
  };

  programs = {
   zsh.enable = true;
   steam.enable = true;
   dconf.enable = true;
   hyprland.enable = true;
   hyprland.xwayland.enable = true;
  };
   
  virtualisation.libvirtd.enable = true;

  fonts.fonts = with pkgs; [ nerdfonts ];

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
  security = {
    pam.services.swaylock = {
        text = ''
          auth include login
        '';
      };
    rtkit.enable = true;
  };

  users.users.wick3d = {
    isNormalUser = true;
    description = "Anthony A";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

   environment.systemPackages = with pkgs; [
    betterdiscordctl
    betterlockscreen
    bitwarden
    brave
    btop
    caffeine-ng
    calcurse
    cargo
    discord
    dunst
    exa
    feh
    firefox
    gcc
    git
    gnumake
    home-manager
    killall
    kitty
    libdrm
    libnotify
    libratbag
    libreoffice-fresh
    lutris
    lxappearance
    neofetch
    neovim
    nodePackages.pyright
    nodePackages.vscode-langservers-extracted
    nodePackages_latest.live-server
    nodePackages_latest.vim-language-server
    nodejs
    nur.repos.reedrw.picom-next-ibhagwan
    pamixer
    pavucontrol
    pcmanfm
    piper
    playerctl
    python
    python310Packages.pylsp-mypy
    python310Packages.pynvim
    python310Packages.python-lsp-server
    python311
    ranger
    ripgrep
    rofi-wayland
    scrot
    spotify
    swaybg
    swaylock-effects
    tmux
    universal-ctags
    unzip
    vim-vint    
    virt-manager
    waybar
    wget
    wlogout
    xclip
    xdg-desktop-portal-hyprland
    xdotool 
    zsh
  ];

  nix = {
   settings = {
   	auto-optimise-store = true;
   	experimental-features = [ "nix-command" "flakes" ];
   };
   gc = {
   	automatic = true;
   	dates = "weekly";
   	options = "--delete-older-than 7d";
   };
  };
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  system = {
  autoUpgrade.enable = true;
  autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
  stateVersion = "23.05"; 
  };
}
