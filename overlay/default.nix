self: super: {
  wrap = self.callPackage ./lib/wrap.nix { };
  mkMenu = self.callPackage ./pkgs/menus { };
  jackrabbit = self.callPackage ./pkgs/jackrabbit.nix { };

  lib-autorandr = (import ./lib/autorandr.nix);

  #rofi-unwrapped = super.rofi-unwrapped.overrideAttrs (old: rec {
  #version = "2f41bf89acb6f2e479a43deef7027d622da0a0f5";
  #src = self.fetchFromGitHub {
  #owner = "zabot";
  #repo = "rofi";
  #rev = version;
  #fetchSubmodules = true;
  #sha256 = "0zzh0qdl2bwff2f56493ps7n8ag55vkjdc6ja4pzvqdq7f4736bn";
  #};
  #});
}
