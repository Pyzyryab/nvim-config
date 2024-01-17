require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or 'all' (the five listed parsers should always be installed)
  ensure_installed = {
	  'rust',
	  'cpp',
	  'make',
	  'cmake',
	  'doxygen',
	  'c',


	  'python',
	  'java',
	  'kotlin',
	  'zig',
	  'dart',
	  'go',
	  'ruby',
	  'lua',

	  'sql',
	  'query',
	  'graphql',

	  'javascript',
	  'typescript',
	  'yaml',
	  'xml',
	  'html',
	  'css',
	  'scss',
	  'json',
	  'json5',

	  'latex',
	  'markdown',
	  'toml',
	  'matlab',
	  'meson',
	  'regex',
	  'llvm',
	  'godot_resource',
	  
	  'vim',
	  'vimdoc',

	  'gitignore',
	  'gitattributes',
	  -- 'git_commit',
	  'git_rebase',
	  'git_config'
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

 highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
