return{
  "kiyoon/Korean-IME.nvim",
  keys = {
    {
      "<F12>",
      function() require("korean_ime").change_mode() end,
      mode = { "i", "n", "x", "s" },
      desc = "한/영 전환",
    },
    {
      "<F9>",
      function() require("korean_ime").convert_hanja() end,
      mode = { "i" },
      desc = "한자 변환",
    },
  },
  config = function()
    require("korean_ime").setup()

    -- 한자 변환 추가 매핑 (Insert 모드에서 실행)
    vim.keymap.set("i", "<F9>", function()
      require("korean_ime").convert_hanja()
    end, { noremap = true, silent = true, desc = "한자" })

    -- Lualine 설정 패치
    -- 이미 lualine이 로드된 상태라면 여기서 옵션만 업데이트
    local ok, lualine = pcall(require, "lualine")
    if ok then
      lualine.setup({
        sections = {
          lualine_z = {
            {
              function()
                local ime = package.loaded["korean_ime"]
                if not ime then return "" end
                local mode = require("korean_ime").get_mode()
                if mode == "en" then
                  return "A"
                elseif mode == "ko" then
                  return "한"
                end
              end,
              color = { fg = "#ffffff", gui = "bold" }, -- 원하면 삭제해도 됨
            },
          },
        },
      })
    end
  end,
}

