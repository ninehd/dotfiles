set background=light " or light if you want light mode
set number

call plug#begin()
" List your plugins here
Plug 'itchyny/lightline.vim'
Plug 'shaunsingh/solarized.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'Luxed/ayu-vim'
call plug#end()

if has('termguicolors')
  set termguicolors
endif

" Important!!
if has('termguicolors')
  set termguicolors
endif

" For light version.
set background=dark

" https://github.com/Luxed/ayu-vim
let g:ayucolor="dark"
let g:ayu_italic_comment = 0
let g:ayu_sign_contrast = 1
let g:ayu_extended_palette = 1
let g:lightline = { 'colorscheme': 'ayu' }
colorscheme ayu
