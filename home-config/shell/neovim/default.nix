{ inputs, ... }: 
let system = "x86_64-linux";
pkgs = import inputs.nvimpkgs { inherit system; };
in {
	imports = [ inputs.nixvim.homeManagerModules.nixvim ];

	programs.nixvim = {
		# Base
		package = pkgs.neovim-unwrapped;
		enable = true;
		vimAlias = true;
		viAlias = true;
		defaultEditor = true;

		# Config
		globals.mapleader = " ";
		opts = {
			showmode = false;
			wrap = false;
			conceallevel = 2;
			number = true;
			relativenumber = true;
			shiftwidth = 4;
			tabstop = 4;
			smartindent = true;
		};
		clipboard.register = "unnamedplus";

		# Keymaps
		keymaps = [
			{
				action = "<cmd>Telescope live_grep<CR>";
				key = "<leader>tg";
			}
			{
				action = "<cmd>Telescope find_files<CR>";
				key = "<leader>tf";
			}
			{
				action = "<cmd>Oil<CR>";
				key = "-";
			}
			{
				action = "<cmd>noh<CR>";
				key = "<Esc>";
				mode = "n";
			}
			{
				action = "<cmd>AerialToggle!<CR>";
				key = "<leader>a";
			}
			{
				action = "<cmd>BufferNext<CR>";
				key = "<A-.>";
			}
			{
				action = "<cmd>BufferNext<CR>";
				key = "<A-Tab>";
			}
			{
				action = "<cmd>BufferPrev<CR>";
				key = "<A-,>";
			}
			{
				action = "<cmd>BufferClose<CR>";
				key = "<leader>w";
			}
			{
				action = "<cmd>ToggleTerm direction=float<CR>";
				key = "<leader>f";
			}
			{
				action = "<cmd>lua require('persistence').load()<CR>";
				key = "<leader>qs";
			}
			{
				action = "<cmd>lua require('persistence').load( { last = true })<CR>";
				key = "<leader>ql";
			}
		];

		# Plugins
		plugins = {
			alpha.enable = true;
			image.enable = true;
			indent-blankline.enable = true;
			telescope.enable = true;
			flash.enable = true;
			persistence.enable = true;
			surround.enable = true;
			trouble.enable = true;
			treesitter.enable = true;
			oil.enable = true;
			tmux-navigator.enable = true;
			nvim-autopairs.enable = true;
			toggleterm.enable = true;
			lualine.enable = true;
			barbar.enable = true;
			neocord.enable = true;

			trouble.settings = {
				auto_open = true;
				auto_close = true;
			};

			alpha.layout = let
				padding = val: {
					type = "padding";
					inherit val;
				};
			in [
				(padding 5)
				{
					opts = {
						hl = "AlphaHeader";
						position = "center";
					};
					type = "text";
					val = [
						" _                _________ _______ "
						"( (    /||\\     /|\\__   __/(       )"
						"|  \\  ( || )   ( |   ) (   | () () |"
						"|   \\ | || |   | |   | |   | || || |"
						"| (\\ \\) |( (   ) )   | |   | |(_)| |"
						"| | \\   | \\ \\_/ /    | |   | |   | |"
						"| )  \\  |  \\   /  ___) (___| )   ( |"
						"|/    )_)   \\_/   \\_______/|/     \\|"
					];
				}
				(padding 5)
				{
					type = "button";
					val = "󰈔 New";
					opts = {
						keymap = [
							"n"
							"n"
							"<cmd>ene<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						shortcut = "n";

						position = "center";
						cursor = 3;
						width = 38;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				(padding 2)
				{
					type = "button";
					val = "󰉋 Oil";
					opts = {
						shortcut = "-";

						position = "center";
						cursor = 3;
						width = 38;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				(padding 2)
				{
					type = "button";
					val = " Restore";
					opts = {
						keymap = [
							"n"
							"r"
							"<cmd>lua require('persistence').load({ last = true })<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						shortcut = "r";

						position = "center";
						cursor = 3;
						width = 38;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				(padding 2)
			];

			# LSP
			lsp = {
				enable = true;
				servers = {
					clangd.enable = true;
					nixd.enable = true;
					pyright.enable = true;
					gopls.enable = true;
				};
			};
			# Lint
			lint = {
				enable = true;
				lintersByFt = {
					go = [ "golangcilint" ];
				};
			};
			# Cmp
			cmp = {
				enable = true;
				autoEnableSources = true;
				settings = {
					sources =
						[ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
					mapping = {
						"<M-CR>" = "cmp.mapping.confirm({ select = true })";
						"<C-Space>" = "cmp.mapping.complete()";
						"<Tab>" =
							"	cmp.mapping(function(fallback)\n	if cmp.visible() then\n		cmp.select_next_item()\n	else\n		fallback()\n	end\n	end, {'i', 's'})\n";
						"<S-Tab>" =
							"	cmp.mapping(function(fallback)\n	if cmp.visible() then\n		cmp.select_prev_item()\n	else\n		fallback()\n	end\n	end, {'i', 's'})\n";
					};
				};
			};
		};
		extraPlugins = with pkgs.vimPlugins; [
			{
				plugin = aerial-nvim;
				config =
					"	lua require('aerial').setup({on_attach = function(bufnr) vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})end})\n";
			}
			{
				plugin = comment-nvim;
				config = "	lua require('Comment').setup()\n";
			}
			vim-go
			dressing-nvim
			{
				plugin = pkgs.vimUtils.buildVimPlugin {
					name = "nerdy.nvim";
					src = pkgs.fetchFromGitHub {
						owner = "2KAbhishek";
						repo = "nerdy.nvim";
						rev = "1ad36242f40a8fd95ae5711258540a07a5dabb51";
						sha256 = "sha256-xIWeN4/wY8Jzi7iEuJFkEUXmTVQ6OK+r/7XYDX/5NqM=";
					};
				};
			}
			{
				plugin = pkgs.vimUtils.buildVimPlugin {
					name = "cphelper.nvim";
					src = pkgs.fetchFromGitHub {
						owner = "p00f";
						repo = "cphelper.nvim";
						rev = "ab259315496514d58b2021048ef40437ad0f5814";
						sha256 = "sha256-7vEL8GJ1pOOA/VwNcSskQzjEbegwVkHCm4YXzWAMhsk=";
					};
				};
			}
		];

	};
}
