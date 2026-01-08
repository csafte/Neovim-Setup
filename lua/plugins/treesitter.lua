return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parsers to install for use in your editor.
			ensure_installed = {
				"c",
				"lua",
				"python",
                "rust",
                "php"

			},
			-- Install parsers asynchronously.
			sync_install = false,
			-- Automatically install parsers for new languages.
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
