let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/master.tar.gz") {
   overlays = [(_: super: {libxml2 = super.libxml2.override {enableHttp=true;};})];
 };
 
  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages) 
      icosa;
  };
   
  system_packages = builtins.attrValues {
    inherit (pkgs) 
      R;
  };
  
in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

  buildInputs = [  rpkgs system_packages   ];
  
}
