return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = { enable = false },
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },

    notes_subdir = "0 Inbox",
    new_notes_location = "notes_subdir",
    disable_frontmatter = true,

    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
      substitutions = {
        year = function()
          return os.date("%Y")
        end,
        month = function()
          return os.date("%m")
        end,
        day = function()
          return os.date("%d")
        end,
        week = function()
          return os.date("%V")
        end,
        weekday = function()
          return os.date("%A")
        end,
      }
    },


    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      -- vim.fn.jobstart({ "open", url }) -- Mac OS
      vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      -- vim.ui.open(url) -- need Neovim 0.10.0+
    end,
  },
}
