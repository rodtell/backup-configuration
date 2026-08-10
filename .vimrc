vim9script
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
set backspace=indent,eol,start
filetype plugin indent on
syntax on
set swapfile
set directory=$HOME/.vim/swap//
set backup
set backupdir=$HOME/.vim/backup//
set undofile
set undodir=$HOME/.vim/undo//
set noshowmode
set updatetime=500
set termguicolors
set signcolumn=yes
set foldmethod=indent
set cursorline

# AUTO-SAVE
augroup AutoSaveGroup
    autocmd!
    autocmd BufLeave,FocusLost,InsertLeave * if &modified && !empty(expand('%')) && &buftype == '' | write | endif
augroup END

# AUTO-CLOSE BRACKETS, QUOTES, PARENTESIS
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

# PACKADD
packadd! comment

# PLUGINS MANAGED BY VIM-PLUG
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-fuzzbox/fuzzbox.vim'
Plug 'honza/vim-snippets'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

# THEME
set background=dark
g:gruvbox_contrast_dark = 'soft'
g:gruvbox_bold = 1
g:gruvbox_italic = 1
colorscheme gruvbox
g:airline_powerline_fonts = 1
g:airline_theme = 'gruvbox'
highlight SignColumn ctermbg=NONE guibg=NONE
highlight CursorLine ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE

# THEME CoC
highlight CocErrorVirtualText ctermbg=Red ctermfg=White guibg=Red guifg=White
highlight CocWarningVirtualText ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
highlight CocInfoVirtualText ctermbg=DarkMagenta ctermfg=White guibg=DarkMagenta guifg=White
highlight CocHintVirtualText ctermbg=Cyan ctermfg=Black guibg=Cyan guifg=Black

highlight CocErrorSign ctermbg=NONE ctermfg=Red guifg=Red guibg=NONE
highlight CocWarningSign ctermbg=NONE ctermfg=Yellow guifg=Yellow guibg=NONE
highlight CocInfoSign ctermbg=NONE ctermfg=DarkMagenta guifg=DarkMagenta guibg=NONE
highlight CocHintSign ctermbg=NONE ctermfg=Cyan guifg=Cyan guibg=NONE

highlight CocErrorHighlight ctermbg=Red ctermfg=White guibg=Red guifg=White
highlight CocWarningHighlight ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
highlight CocInfoHighlight ctermbg=DarkMagenta ctermfg=White guibg=DarkMagenta guifg=White
highlight CocHintHighlight ctermbg=Cyan ctermfg=Black guibg=Cyan guifg=Black

# FUZZBOX KEYMAP
nnoremap <silent> <leader>fb :FuzzyBuffers<CR>
nnoremap <silent> <leader>ff :FuzzyFiles<CR>
nnoremap <silent> <leader>fg :FuzzyGrep<CR>
nnoremap <silent> <leader>fh :FuzzyHelp<CR>
nnoremap <silent> <leader>fi :FuzzyInBuffer<CR>
nnoremap <silent> <leader>fr :FuzzyMru<CR>
nnoremap <silent> <leader>fp :FuzzyPrevious<CR>
nnoremap <silent> <leader>fq :FuzzyQuickfix<CR>

# CoC KEYMAP
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
