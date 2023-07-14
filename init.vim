call plug#begin('~/AppData/Local/nvim/plugged')
"algo
"https://github.com/jakobkogler/Algorithm-DataStructures
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'jakobkogler/Algorithm-DataStructures'


"[theme]
"Plug 'joshdick/onedark.vim'
"Plug 'projekt0n/github-nvim-theme', { 'tag': 'v0.0.7' }
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

" [file browser]
"https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdTree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" [File search]
"https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"[status bar]
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"[terminal]
"https://github.com/voldikss/vim-floaterm
Plug 'voldikss/vim-floaterm'

" [complete code] 
"https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'

"[syntax highlight]
Plug 'yuezk/vim-js'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'jackguo380/vim-lsp-cxx-highlight'

"[debug]
Plug 'puremourning/vimspector'

"[source code version control]
Plug 'tpope/vim-fugitive'

"Plub 'gruvbox-community/gruvbox'
call plug#end()

" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"

set mouse
set listchars=tab:\|\ "table characters
set list
set foldmethod=indent
set foldlevelstart=99 
set number 
syntax on 
"colorscheme onedark "themes
"colorscheme github_dark_default
colorscheme moonfly


" nerdtree 
map <silent> <F11> : NERDTreeToggle<CR>

"imap jj <esc>

"floaterm 
"nnoremap   <silent>   <F5>    :FloatermNew<CR>
"tnoremap   <silent>   <F5>    <C-\><C-n>:FloatermNew<CR>

let s:fontsize = 7
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction

noremap <silent> <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <silent> <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <silent> <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <silent> <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

noremap <silent> <C-l> <C-w><S-l> 
noremap <silent> <C-h> <C-w><S-h> 
noremap <silent> <C-j> <C-w><S-j> 
noremap <silent> <C-k> <C-w><S-k> 
"build
function! CPPSET()
  nnoremap <silent> <buffer> <F5> :w<cr>:!g++ % -O2 -o %< -std=c++14 -I ./<cr><cr>

endfunction


function! JAVASET()
  nnoremap <silent> <buffer> <F8> :!javac %<cr>
endfunction

autocmd FileType cpp    call CPPSET()
autocmd FileType java   call JAVASET()
noremap <silent> <F6> :FloatermNew <CR> 
nnoremap <silent> <C-F6> :FloatermKill<Cr> 
tnoremap <silent> <C-F6> <C-\><C-n>:FloatermKill<Cr> 
nnoremap <silent> <F4> :Ex<cr>
nnoremap <silent> <F3> :bd!<cr>
set autoindent
set ruler         " show cursor position in bottom line
set nu            " show line number
set hlsearch      " highlight search result
" y and d put stuff into system clipboard (so that other apps can see it)
set clipboard=unnamed,unnamedplus
set nowrap
set textwidth=0
set cindent
set timeoutlen=100

" Tab related stuffs
set shiftwidth=4  " tab size = 4
set expandtab
set softtabstop=4
set shiftround    " when shifting non-aligned set of lines, align them to next tabstop

" Searching
set incsearch     " show first match when start typing
set ignorecase    " default should ignore case
set smartcase     " use case sensitive if I use uppercase

" Use the following wildmenu for tab completion
set wildmenu

" Automatically wrap lines that are longer than the window width
set wrap

" Enable line highlighting for the current line
set cursorline

" Highlight the matching part of a brace, bracket, or parenthesis
set showmatch

" Enable smart indenting
set smartindent

"inoremap <silent> <expr> <S-TAB> <M-n>

function! MyTabCompletion()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-P>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=MyTabCompletion()<CR>
function! MyComment()
  let l = getline('.')
  if l =~ '^\s*\/\/'
    let l = substitute(l, '\/\/', '', '')
  else
    let l = '//' . l
  endif
  call setline(line('.'), l)
endfunction
nnoremap <C-m> :call MyComment()<CR>

function! MyCommentLines()
  let [start_line, end_line] = [line("'<"), line("'>")]
  for line_num in range(start_line, end_line)
    let line_text = getline(line_num)
    if line_text =~ '^\s*\/\/'
      let line_text = substitute(line_text, '^\s*\/\/', '', '')
    else
      let line_text = '//' . line_text
    endif
    call setline(line_num, line_text)
  endfor
endfunction

vnoremap <C-m> :<C-u>call MyCommentLines()<CR>
"complete code

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

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

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

