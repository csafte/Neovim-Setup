-- lua/plugins/dotenv.lua
return {
	"ellisonleao/dotenv.nvim",
	priority = 1000,
	config = function()
		require("dotenv").setup({
			enable_on_load = true,
			verbose = false,
	    path = vim.fn.stdpath("config") .. "/.env"
    })
	end,
}
