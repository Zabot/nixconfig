{ pkgs,  ... }:
{
  vim-gas = pkgs.vimUtils.buildVimPlugin {
    name = "vim-gas";
    src = pkgs.fetchFromGitHub {
      owner = "Shirk";
      repo = "vim-gas";
      rev = "c6da2e0f6663c6b1dbd954c55324035e59636f31";
      sha256 = "0y2dyksi1fbwgr8fg98bxrz4wcc7pl9aymbciml357yaq5bs8hx8";
    };
  };

  easygrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-easygrep";
    src = pkgs.fetchFromGitHub {
      owner = "dkprice";
      repo = "vim-easygrep";
      rev = "d0c36a77cc63c22648e792796b1815b44164653a";
      sha256 = "0y2p5mz0d5fhg6n68lhfhl8p4mlwkb82q337c22djs4w5zyzggbc";
    };
  };

  go-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "go-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "c75824b1f050c153ebfd5be65a318b9d4463d5a9";
      sha256 = "azO+Eay3V9aLyJyP1hmKiEAtr6Z3OqlWVu4v2GEoUdo=";
    };
  };

  solarized = pkgs.vimUtils.buildVimPlugin {
    name = "solarized";
    src = pkgs.fetchFromGitHub {
      owner = "maxmx03";
      repo = "solarized.nvim";
      rev = "a4101cefa7c1dbece51d834df5cd9eae8acff8c2";
      sha256 = "sha256-j7MF0abTu/MdDo7t1pjm0s57HtiX192eFnjx9W081k0=";
    };
  };
}
