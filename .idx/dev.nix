# To learn more about how to use Nix to configure your environment
# see: https://firebase.google.com/docs/studio/customize-workspace
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  # Use https://localhost:8978
  packages = [
    pkgs.php
    # pkgs.docker-compose # WAJIB: Tambahkan ini agar bisa membaca docker-compose.yml
    # pkgs.nodejs_20 # Uncomment jika butuh nodejs
  ];

  # Sets environment variables in the workspace
  env = {};
  
  services.docker.enable = true;
  
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];


    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Contoh: npm-install = "npm install";
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Menjalankan container di background secara otomatis saat workspace dibuka
      };
    };
  };
}