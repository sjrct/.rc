require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require('nvim-treesitter.config').setup({
  highlight = {
    enable = true
  }
})

require('which-key').setup({
  delay = 700,
  ---@param ctx { mode: string, operator: string }
  defer = function(ctx)
    --if vim.list_contains({ "d", "y" }, ctx.operator) then
    --  return true
    --end

    -- Defer when entering visual mode
    return vim.list_contains({ "v", "V", "<C-V>" }, ctx.mode)
  end,
})
