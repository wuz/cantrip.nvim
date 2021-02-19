local map = require'utils'.map

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

map('i', '<silent><expr> <C-Space>', 'compe#complete()', noremap)
map('i', '<silent><expr> <CR>', "compe#confirm('<CR>')", noremap)
map('i', '<silent><expr> <C-e>', "compe#close('<C-e>')", noremap)
map('i', '<silent><expr> <C-f>', "compe#scroll({ 'delta': +4 })", noremap)
map('i', '<silent><expr> <C-d>', "compe#scroll({ 'delta': -4 })", noremap)
