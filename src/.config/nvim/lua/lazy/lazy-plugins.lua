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
  -- Direct installation
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  'kergoth/vim-bitbake', -- Bitbake support

  -- Plugin with configuration
})

-- vim: ts=2 sts=2 sw=2 et
