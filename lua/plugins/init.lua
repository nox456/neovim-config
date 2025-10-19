return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-project.nvim" },
    config = function()
      local project_actions = require "telescope._extensions.project.actions"
      require("telescope").setup {
        defaults = {
          initial_mode = "normal",
        },
        extensions = {
          project = {
            theme = "dropdown",
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr)
            end,
          },
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "nvchad.configs.nvimtree"
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = { "BufEnter *.*", "BufEnter */.git/*" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
  },
  {
    "mason-org/mason.nvim",
    priority = 10,
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "nvchad.configs.mason"
    end,
  },
  {
    "famiu/bufdelete.nvim",
    lazy = false,
  },
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<leader><Tab>",
        },
      }
    end,
  },
  {
    "NeogitOrg/neogit",
    lazy = false,
    opts = {
      disable_hint = true,
      disable_insert_on_commit = false,
      console_timeout = 8000,
      auto_show_console = false,
      status = {
        HEAD_folded = true,
      },
      commit_editor = {
        spell_check = false,
        kind = "floating",
      },
      log_view = {
        kind = "floating"
      },
      graph_style = "unicode",
      integrations = {
        telescope = false
      }
    },
  },
}
