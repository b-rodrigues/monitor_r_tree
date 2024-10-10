let
 pkgs = import (fetchTarball "https://github.com/b-rodrigues/nixpkgs/archive/7f429cb10d52b9c6e3763762e8c06e1b4d5999b3.tar.gz") {};
 
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
