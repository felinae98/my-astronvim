return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "solarized",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },

    config = {
      pyright = {
        before_init = function(_, config)
          local configs = require('lspconfig/configs')
          local util = require('lspconfig/util')

          local path = util.path

          local function get_python_path(workspace)
            -- Use activated virtualenv.
            if vim.env.VIRTUAL_ENV then
              return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
            end

              -- Find and use virtualenv via poetry in workspace directory.
            local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
            if match ~= '' then
              local venv = vim.fn.trim(vim.fn.system('poetry --directory ' .. workspace .. ' env info -p'))
              return path.join(venv, 'bin', 'python')
            end

            -- Find and use virtualenv in workspace directory.
            for _, pattern in ipairs({'*', '.*'}) do
              local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
              if match ~= '' then
                return path.join(path.dirname(match), 'bin', 'python')
              end
            end

            -- Fallback to system Python.
            return exepath('python3') or exepath('python') or 'python'
          end

          config.settings.python.pythonPath = get_python_path(config.root_dir)
        end
      }
    }
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
