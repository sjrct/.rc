-- vim:foldmethod=marker
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


local augrp = vim.api.nvim_create_augroup('plugins.lua', {clear = true})

--: Completion {{{
vim.api.nvim_create_autocmd('InsertCharPre', {
  group = augrp,
  buffer = vim.api.nvim_get_current_buf(),
  callback = function()
    if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
      return
    end

    local char = vim.v.char
    local line = vim.api.nvim_get_current_line()

    -- Trigger when typing non-whitespace char on whitespace-only line
    if not char:match('%s') and line:match('^%s*$') and vim.opt.omnifunc:get() ~= "" then
      local key = vim.keycode('<C-x><C-o>')
      vim.api.nvim_feedkeys(key, 'm', false)
    end
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augrp,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end
    -- Enable auto-completion using server-defined trigger characters
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
  end
})
--: }}}

vim.diagnostic.config({
  -- virtual_lines = true,
  virtual_text = true,
})

--: Sign marks {{{
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  -- bookmark_0 = {
  --   sign = "⚑",
  --   virt_text = "hello world",
  --   -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
  --   -- defaults to false.
  --   annotate = false,
  -- },
  mappings = {}
}
--: }}}
