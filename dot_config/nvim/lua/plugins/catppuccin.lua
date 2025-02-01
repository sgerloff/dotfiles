return {
	{ 
		"catppuccin/nvim", 
		version = "^1.9",
		name = "catppuccin", 
		priority = 1000,
		config = function() vim.cmd.colorscheme "catppuccin-mocha" end
	},
}
