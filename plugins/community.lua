local utils = require "astronvim.utils"

function remove_from_list(list, value)
  for i = #list, 1, -1 do
    if list[i] == value then
      table.remove(list, i)
    end
  end

  return list
end

return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.pack.go" },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        remove_from_list(opts.ensure_installed, "gofumpt")
    end,
  },

  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.search.nvim-hlslens" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.split-and-window.edgy-nvim" },
  { import = "astrocommunity.split-and-window.mini-map" },
  { import = "astrocommunity.split-and-window.windows-nvim" },
  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  { import = "astrocommunity.workflow.hardtime-nvim" },
}
