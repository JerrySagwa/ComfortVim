"====================
"== Enhance Editor ==
"====================

colorscheme industry

syntax on
set updatetime=300
set number
set hidden
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab
set ignorecase
set smartcase
set jumpoptions=stack
set scrolloff=4
set autoindent
set cindent
let mapleader=' '

inoremap jj <Esc>
"======== windows ========
nnoremap <leader>w :w<cr>
nnoremap <leader>gh <c-w>h
nnoremap <leader>gj <c-w>j
nnoremap <leader>gk <c-w>k
nnoremap <leader>gl <c-w>l
nnoremap <leader>gg <c-w>w
nnoremap <leader>ss <c-w>s
nnoremap <leader>sv <c-w>v

"=========================
"======= terminal ========
"=========================
" switch terminal in terminal mode
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNext<CR>
" new terminal windows
let g:floaterm_keymap_new = '<Leader>tw'
" switch terminal mode
let g:floaterm_keymap_toggle = '<Leader>tt'
" close terminal
let g:floaterm_keymap_kill = '<Leader>tk'
" hide terminal
let g:floaterm_keymap_hide = '<Leader>th'
let g:floaterm_wintype = 'float'
let g:floaterm_position = 'center'
let g:floaterm_width = 0.6
let g:floaterm_height = 0.8
let g:floaterm_title = 'floaterm: $1/$2'

nnoremap   <silent>   <Leader>tw    :FloatermNew<CR>
tnoremap   <silent>   <Leader>tw    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <Leader>tp    :FloatermPrev<CR>
tnoremap   <silent>   <Leader>tp    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <Leader>tn    :FloatermNext<CR>
tnoremap   <silent>   <Leader>tn    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <Leader>tt   :FloatermToggle<CR>
tnoremap   <silent>   <Leader>tt   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <Leader>tk   :FloatermKill<CR>
tnoremap   <silent>   <Leader>tk   <C-\><C-n>:FloatermKill<CR>

"======= Tagbar ========
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

"====================
"===   plugins   ====
"====================
call plug#begin('~/.config/nvim/plugged')

" file explorer
Plug 'preservim/nerdtree'

" surround
Plug 'tpope/vim-surround'

" conquer of completion
" lsp
" before : nodejs >= 14 npm yarn
Plug 'neoclide/coc.nvim'

" pairs for ( { [
Plug 'jiangmiao/auto-pairs'

" startify
Plug 'mhinz/vim-startify'

" highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'

" terminal
Plug 'voldikss/vim-floaterm'

" comment
Plug 'scrooloose/nerdcommenter'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" catgs & tagbar
" https://docs.ctags.io/en/latest/autotools.html#gnu-linux-distributions
Plug 'majutsushi/tagbar'

" snippets
Plug 'honza/vim-snippets'

call plug#end()

"====================
"==== nerdtree ======
"====================
" R when when focus is in the NERDTree column 
" would refresh NERDTree manually.
nnoremap <leader>p :NERDTreeToggle<cr>
nnoremap <leader>v :NERDTreeFind<cr>

"==== nerdcommenter ====
let g:NERDSpaceDelimes=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'


"===========================
"==== neoclide/coc.nvim ====
"===========================

" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-vimlsp',
      \ 'coc-cmake',
      \ 'coc-highlight',
      \ 'coc-pyright'
      \ ]

set signcolumn=number
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight link CocHighlightText Visual
" autocmd CursorHold * silent call CocActionAsync('highlight')   " TODO

nmap <leader>rn <Plug>(coc-rename)

" format
xmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocAction('format')
nmap <Leader>F :Format<cr>

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" diagnostic info
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <LEADER>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" statusline support
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}  "TODO

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:generate_compile_command()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('build'))
    execute 'silent !mkdir build'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B build'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_command()

"====== cxx-highlight ======
hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymClass cxxTypeAlias