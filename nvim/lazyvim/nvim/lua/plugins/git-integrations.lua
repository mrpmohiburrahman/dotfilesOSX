return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },

    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    config = true,
  },
  -- LazyGit integration with Telescope
  -- {
  --   "kdheepak/lazygit.nvim",
  --   keys = {
  --     {
  --       ";c",
  --       ":LazyGit<Return>",
  --       silent = true,
  --       noremap = true,
  --     },
  --   },
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
}
