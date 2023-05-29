-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Skippind language servers

-- add `pyright` to `skipped_servers` list   
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- remove `jedi_language_server` from `skipped_servers` list   
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- Keymappings 
-- basic movement remappings for Colemak
-- normal mode
vim.api.nvim_set_keymap('n', 's', 'h', {noremap = true})
vim.api.nvim_set_keymap('n', 't', 'j', {noremap = true})
vim.api.nvim_set_keymap('n', 'n', 'k', {noremap = true})
vim.api.nvim_set_keymap('n', 'e', 'l', {noremap = true})
-- virual mode
vim.api.nvim_set_keymap('v', 's', 'h', {noremap = true})
vim.api.nvim_set_keymap('v', 't', 'j', {noremap = true})
vim.api.nvim_set_keymap('v', 'n', 'k', {noremap = true})
vim.api.nvim_set_keymap('v', 'e', 'l', {noremap = true})

-- Keymappings for window movements
vim.api.nvim_set_keymap('n', '<C-w>s', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>t', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>n', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>e', '<C-w>l', {noremap = true})

-- General settings
vim.opt.relativenumber = true



-- Plugins section
lvim.plugins = {
{
  'wfxr/minimap.vim',
  build = "cargo install --locked code-minimap",
  -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
  config = function ()
    vim.cmd ("let g:minimap_width = 10")
    vim.cmd ("let g:minimap_auto_start = 1")
    vim.cmd ("let g:minimap_auto_start_win_enter = 1")
  end,
},
{
  "tpope/vim-surround",

  -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
  -- setup = function()
    --  vim.o.timeoutlen = 500
  -- end
},
{
  "monaqa/dial.nvim",
  event = "BufRead",
  config = function()
    local dial = require "dial"
    vim.cmd [[
    nmap <C-a> <Plug>(dial-increment)
      nmap <C-x> <Plug>(dial-decrement)
      vmap <C-a> <Plug>(dial-increment)
      vmap <C-x> <Plug>(dial-decrement)
      vmap g<C-a> <Plug>(dial-increment-additional)
      vmap g<C-x> <Plug>(dial-decrement-additional)
    ]]

    dial.augends["custom#boolean"] = dial.common.enum_cyclic {
      name = "boolean",
      strlist = { "true", "false" },
    }
    table.insert(dial.config.searchlist.normal, "custom#boolean")

    -- For Languages which prefer True/False, e.g. python.
    dial.augends["custom#Boolean"] = dial.common.enum_cyclic {
      name = "Boolean",
      strlist = { "True", "False" },
    }
    table.insert(dial.config.searchlist.normal, "custom#Boolean")
  end,
},

{
  -- Note taking application
  "metakirby5/codi.vim",
  cmd = "Codi",
},
{
  "folke/trouble.nvim",
    cmd = "TroubleToggle",
},
{
  "simrat39/symbols-outline.nvim",
  config = function()
    require('symbols-outline').setup()
  end
},
{
  "ray-x/lsp_signature.nvim",
  event = "BufRead",
  config = function() require"lsp_signature".on_attach() end,
},
{
  "nacro90/numb.nvim",
  event = "BufRead",
  config = function()
  require("numb").setup {
    show_numbers = true, -- Enable 'number' for the window while peeking
    show_cursorline = true, -- Enable 'cursorline' for the window while peeking
  }
  end,
},
{
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = "BufRead",
},
{
  "rmagatti/goto-preview",
  config = function()
  require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
        resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        };
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true; -- Focus the floating window when opening it.
        dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
    }
  end,
},
{
  "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          })
  end,
},
{
  "windwp/nvim-spectre",
  event = "BufRead",
  config = function()
    require("spectre").setup()
  end,
},
{
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup()
  end,
},
{
  "folke/todo-comments.nvim",
  event = "BufRead",
  config = function()
    require("todo-comments").setup()
  end,
},
{
  "phaazon/hop.nvim",
  event = "BufRead",
  config = function()
    require("hop").setup()
    vim.api.nvim_set_keymap("n", "o", ":HopChar2<cr>", { silent = true })
    vim.api.nvim_set_keymap("n", "O", ":HopWord<cr>", { silent = true })
  end,
},
}

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

-- Trouble plugin keybindings
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
