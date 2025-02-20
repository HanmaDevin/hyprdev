-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- vim options
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.wrap = true

lvim.keys.insert_mode["jk"] = "<Esc>"

lvim.format_on_save = {
  enabled = true
}
-- lvim config
lvim.colorscheme = "catppuccin-mocha"
lvim.builtin.lualine.options.theme = "dracula"

lvim.builtin.alpha.dashboard.section.header.val = {
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]]
}

-- lsp config
lvim.builtin.which_key.mappings["H"] = { "<cmd>vim.lsp.buf.hover<CR>", "Show documentation" }
lvim.builtin.which_key.mappings["G"] = {
  name = "Code",
  d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
  D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
  r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" },
}

lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.nvimtree.setup.view = { adaptive_size = true }


lvim.lsp.on_attach_callback = function(client, bufnr)
  require("lsp_signature").on_attach()
end

-- set mappings
lvim.builtin.which_key.mappings["g"] = {}
lvim.builtin.which_key.mappings["bk"] = { "<cmd>BufferKill<CR>", "Kill Buffer" }
lvim.builtin.which_key.mappings["lg"] = { "<cmd>LazyGit<CR>", "Lazygit" }
lvim.builtin.nvimtree.setup.view.side = "right"

-- additional plugins
lvim.plugins = {
  { "catppuccin/nvim" },
  { "github/copilot.vim" },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup({
        -- …
      })
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "kdheepak/lazygit.nvim",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }
        }
      },
    },
  },
}
