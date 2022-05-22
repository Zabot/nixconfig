self: super:
{
  wrap = self.callPackage ./lib/wrap.nix {};
  mkMenu = self.callPackage ./pkgs/menus {};
  jackrabbit = self.callPackage ./pkgs/jackrabbit.nix {};

  lib-autorandr = (import ./lib/autorandr.nix);

  rofi-unwrapped = super.rofi-unwrapped.overrideAttrs (old: rec {
    version = "2f41bf89acb6f2e479a43deef7027d622da0a0f5";
    src = self.fetchFromGitHub {
      owner = "zabot";
      repo = "rofi";
      rev = version;
      fetchSubmodules = true;
      sha256 = "0zzh0qdl2bwff2f56493ps7n8ag55vkjdc6ja4pzvqdq7f4736bn";
    };
  });

  i3lock-color = super.i3lock-color.overrideAttrs (old: rec {
    version = "58198de44ab75892e604645aa6d870d247c9b8d7";
    src = self.fetchFromGitHub {
      owner = "zabot";
      repo = "i3lock-color";
      rev = version;
      sha256 = "1fn2cj0j28g0rb19qv42lpzhyin7kzv5j1mqsvcdlr2mqd8q5pkm";
    };
  });

  dunst = super.dunst.overrideAttrs (old: rec {
    version = "v1.8.1";
    src = self.fetchFromGitHub {
      owner = "dunst-project";
      repo = "dunst";
      rev = version;
      sha256 = "19bh5789whlc0n5wbyx3yx8px93hccn42f1p6i1dz96hdkk5mjb8";
    };
  });

  autorandr = super.autorandr.overrideAttrs (old: rec {
    version = "1.12.1";
    src = self.fetchFromGitHub {
      owner = "phillipberndt";
      repo = "autorandr";
      rev = version;
      sha256 = "04w624c4iz99j7jrj3lmc8pwxrr08hlpdc1y0hgfngbs0mp6f8zd";
    };
    patches = [ pkgs/autorandr/edid.diff ];
  });
}
