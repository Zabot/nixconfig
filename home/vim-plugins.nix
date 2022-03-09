(self: super:
{
  #vim-gitgutter = buildVimPlugin {
    #name = "vim-gitgutter";
    #src = fetchFromGitHub {
      #owner = "airblade";
      #repo = "vim-gitgutter";
      #rev = "7b81a8a22607f073b76b106e2d5e63cc936b0d25";
      #sha256 = "19v2akrhhfb9zy7mvljjwvi7lqrnviw88gxh4xmpy82vghiwdrfs";
    #};
  #};

	vimPlugins = super.vimPlugins.overrideScope' {
		vim-gas = buildVimPluginFrom2Nix {
			pname = "align";
			version = "0.14";
			src = fetchFromGitHub {
				owner = "Shirk";
				repo = "vim-gas";
				rev = "c6da2e0f6663c6b1dbd954c55324035e59636f31";
				sha256 = "0acacr572kfh7jvavbw61q5pkwrpi1albgancma063rpax1pddgp";
			};
			meta.homepage = "https://github.com/Shirk/vim-gas";
		};
	};
})
