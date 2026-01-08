-- lua/plugins/dotenv.lua
return {
  "ellisonleao/dotenv.nvim",
  priority = 1000,
  config = function()
    require("dotenv").setup({
      enable_on_load = true,
      verbose = false,
      -- 핵심 수정: config 폴더 안의 lua 폴더 안에 있는 .env를 가리킵니다.
          })
  end,
}
