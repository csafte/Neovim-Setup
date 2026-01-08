-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = "C:/Users/gim95/AppData/Local/Programs/Python/Python312/python.exe"

require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- ✅ 자동 업데이트 체크 및 알림 비활성화
	checker = {
		enabled = false, -- 자동 업데이트 체크 끄기
		notify = false, -- 업데이트 알림 끄기
	},
	-- ✅ 변경 감지 알림 비활성화
	change_detection = {
		enabled = true, -- 설정 파일 변경 감지는 유지
		notify = false, -- 변경 알림은 끄기
	},
})

vim.cmd("colorscheme tokyonight-moon")
