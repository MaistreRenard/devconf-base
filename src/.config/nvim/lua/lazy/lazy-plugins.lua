-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- [[ Editor plugins ]]
  require 'plugins.editor.autopairs',
  require 'plugins.editor.conform',
  require 'plugins.editor.colorscheme',
  require 'plugins.editor.guess-indent',
  require 'plugins.editor.indent_line',
  require 'plugins.editor.lsp',
  require 'plugins.editor.todo-comments',
  require 'plugins.editor.treesitter',

  -- [[ Language plugins]]
  require 'plugins.lang.bitbake',
  require 'plugins.lang.blink-cmp',
  require 'plugins.lang.lint',

  -- [[ Utils plugins]]
  require 'plugins.utils.gitsigns',
  require 'plugins.utils.mini',
  require 'plugins.utils.neo-tree',
  require 'plugins.utils.telescope',
  require 'plugins.utils.which-key',
})

-- vim: ts=2 sts=2 sw=2 et
