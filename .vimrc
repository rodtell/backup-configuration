vim9script
# BASIC CONFIGURATION
set number
set showmatch
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set expandtab
set shiftwidth=4
set smarttab	
set softtabstop=4
set ruler	
set undoreload=20000 
set undolevels=2000
set undofile
set undodir=$HOME/.vim/undo//
set backup
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set signcolumn=yes
syntax on
filetype plugin indent on
set laststatus=2
set statusline=\ %{mode()}\ %<%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P\    
set noshowmode
set termguicolors
set foldmethod=indent
set updatetime=500

# AUTO-CLOSE BRACKETS, QUOTES, PARENTESIS, ETC
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ` ``<Left>

# AUTO-SAVE
def AutoSaveFunc()
    if &modified && &buftype == '' && expand('%') != '' && &modifiable
        silent! update
    endif
enddef
augroup AutoSaveGroup
    autocmd!
    autocmd FocusLost,InsertLeave,BufLeave * AutoSaveFunc()
augroup END

# PACKADD
packadd comment

# PLUGINS MANAGED BY VIM-PLUG
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'yegappan/lsp'
Plug 'vim-fuzzbox/fuzzbox.vim'
call plug#end()

# THEME
set background=dark
g:gruvbox_contrast_dark = 'soft'
g:gruvbox_bold = 1
g:gruvbox_italic = 1
colorscheme gruvbox
highlight SignColumn ctermbg=NONE guibg=NONE

# LSP THEME
highlight LspDiagInlineError ctermbg=red ctermfg=white guibg=red guifg=white
highlight LspDiagInlineHint ctermbg=cyan ctermfg=black guibg=cyan guifg=black
highlight LspDiagInlineInfo ctermbg=magenta ctermfg=white guibg=magenta guifg=white
highlight LspDiagInlineWarning ctermbg=yellow ctermfg=black guibg=yellow guifg=black

highlight LspDiagSignErrorText ctermbg=NONE ctermfg=red guibg=NONE guifg=red
highlight LspDiagSignHintText ctermbg=NONE ctermfg=cyan guibg=NONE guifg=cyan
highlight LspDiagSignInfoText ctermbg=NONE ctermfg=magenta guibg=NONE guifg=magenta
highlight LspDiagSignWarningText ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow

highlight LspDiagVirtualTextError ctermbg=red ctermfg=white guibg=red guifg=white
highlight LspDiagVirtualTextHint ctermbg=cyan ctermfg=black guibg=cyan guifg=black
highlight LspDiagVirtualTextInfo ctermbg=magenta ctermfg=white guibg=magenta guifg=white
highlight LspDiagVirtualTextWarning ctermbg=yellow ctermfg=black guibg=yellow guifg=black

# FZF KEYMAP
nnoremap <silent> <leader>fb :FuzzyBuffers<CR>
nnoremap <silent> <leader>fc :FuzzyCommands<CR>
nnoremap <silent> <leader>ff :FuzzyFiles<CR>
nnoremap <silent> <leader>fg :FuzzyGrep<CR>
nnoremap <silent> <leader>fh :FuzzyHelp<CR>
nnoremap <silent> <leader>fi :FuzzyInBuffer<CR>
nnoremap <silent> <leader>fm :FuzzyMru<CR>
nnoremap <silent> <leader>fp :FuzzyPrevious<CR>
nnoremap <silent> <leader>fq :FuzzyQuickfix<CR>
nnoremap <silent> <leader>fr :FuzzyMruCwd<CR>

# LSP KEYMAP
nnoremap <silent> gd <cmd>LspGotoDefinition<cr>
nnoremap <silent> K  <cmd>LspHover<cr>
nnoremap <silent> [d <cmd>LspDiag prev<cr>
nnoremap <silent> ]d <cmd>LspDiag next<cr>
nnoremap <silent> <leader>rn <cmd>LspRename<cr>
nnoremap <silent> <leader>ca <cmd>LspCodeAction<cr>
nnoremap <silent> <leader>f <cmd>LspFormat<cr>

# SNIPPETS KEYMAP
g:user_emmet_leader_key = '<c-e>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

# LSP OPTIONS
var lspOpts = {
    autoComplete: v:true,
    autoHighlightDiags: v:true,
    diagSignErrorText: '■',
    diagSignHintText: '◆',
    diagSignInfoText: '●',
    diagSignWarningText: '▲',
    hideDisabledCodeActions: v:false,
    highlightDiagInline: v:true,
    closePreviewOnComplete: v:true,
    ignoreMissingServer: v:false,
    keepFocusInDiags: v:true,
    keepFocusInReferences: v:true,
    completionTextEdit: v:true,
    maxDiagnostics: 200,
    omniCompleteAllowBare: v:false,
    semanticHighlight: v:true,
    showDiagWithSign: v:true,
    showDiagWithVirtualText: v:true,
    showInlayHints: v:true,
    showSignature: v:true,
    snippetSupport: v:true,
    vsnipSupport: v:true,
    bufferCompletionTimeout: 500,
}

# LSP
var lspServers = [
    {
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: ['--background-index']
    },
    {
        name: 'rust-analuzer',
        filetype: ['rust'],
        path: 'rust-analyzer',
        args: [],
        syncInit: v:true
    },
    {
        name: 'basedpyright',
        filetype: ['python'],
        path: 'basedpyright-langserver',
        args: ['--stdio']
    },
    {
        name: 'vtsls',
        filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact'],
        path: 'vtsls',
        args: ['--stdio']
    },
    {
        name: 'vscode-html-server',
        filetype: ['html'],
        path: 'vscode-html-language-server',
        args: ['--stdio'],
    },
    {
        name: 'vscode-css-server',
        filetype: ['css', 'scss'],
        path: 'vscode-css-language-server',
        args: ['--stdio']
    },
    {
        name: 'vscode-json-server',
        filetype: ['json'],
        path: 'vscode-json-language-server',
        args: ['--stdio']
    },
    {
        name: 'yaml-language-server',
        filetype: ['yaml', 'yml'],
        path: 'yaml-language-server',
        args: ['--stdio']
    },
    {
        name: 'taplo',
        filetype: ['toml'],
        path: 'taplo',
        args: ['lsp', 'stdio']
    }

]
autocmd User LspSetup call LspOptionsSet(lspOpts)
autocmd User LspSetup call LspAddServer(lspServers)


# RUFF FORMAT
def g:RunRuff()
    if &modified
        update
    endif
    const view = winsaveview()
    const output = system("ruff check --fix " .. shellescape(expand("%")) .. " && ruff format " .. shellescape(expand("%")) .. " 2>&1")
    if v:shell_error == 0
        edit!
        winrestview(view)
        redraw
        echo "Ruff: OK"
    else
        redraw
        echohl ErrorMsg
        echo "Ruff: ERROR - " .. substitute(output, "\n", " ", "g")
        echohl None
    endif
enddef
nnoremap <silent> gr :call g:RunRuff()<CR> 

# BIOME FORMAT 
def g:RunBiome()
    if &modified
        update
    endif
    const view = winsaveview()
    const output = system("biome check --write " .. shellescape(expand("%")) .. " 2>&1")
    if v:shell_error == 0
        edit!
        winrestview(view)
        redraw
        echo "Biome: OK"
    else
        redraw
        echohl ErrorMsg
        echo "Biome: ERROR - " .. substitute(output, "\n", " ", "g")
        echohl None
    endif
enddef
nnoremap <silent> gb :call g:RunBiome()<CR>
