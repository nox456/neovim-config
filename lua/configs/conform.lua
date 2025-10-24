local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd", "biome" },
    html = { "prettierd", "biome" },
    javascript = { "prettierd", "biome" },
    typescript = { "prettierd", "biome" },
    json = { "prettierd", "biome" },
    typescriptreact = { "prettierd", "biome" },
    javascriptreact = { "prettierd", "biome" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
