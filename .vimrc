
" On first checkout remember to symlink with
" ln -s ~/.vim/.vimrc ~/.vimrc

call plug#begin('~/.vim/plugged')
Plug 'veloce/vim-aldmeris'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'preservim/nerdtree'
call plug#end()

" Misc settings
" =======================================================

filetype plugin indent on

syntax on

" Remove the standard vim startup screen
set shm+=I
:set guioptions -=T

" Oblivion color scheme
colorscheme aldmeris


" Replace tabs with 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" Soft wrap words
:set linebreak

" Use matmake as standard
set makeprg=matmake2\ -t\ gcc-debug

syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell

" Spelling disable check on http addresses
" https://vi.stackexchange.com/questions/3990/ignore-urls-and-email-addresses-in-spell-file
syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell


let NERDTreeCustomOpenArgs={'file':{'where': 't'}}


" Clang format
" ========================================================0

" Clang format
function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
 
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()



" vim-lsp
" ===============                        
" https://jonasdevlieghere.com/vim-lsp-clangd/
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
else
    echo 'Clangd Not installed'
endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction


augroup lsp_install
        au!
            " call s:on_lsp_buffer_enabled only for languages that has the
            " server registered.
            "     autocmd User lsp_buffer_enabled call
            "     s:on_lsp_buffer_enabled()
            "     augroup END
            "

" Autocompletion
" Use ctrl+n and ctrl+p to step in autocompletion list

" Keymaps
" =====================================0000
" https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
" Remember to add the following to ~/.bash_profile or ~/.bashrc
" To prevent the terminal to catch the ctrl+s
" bind -r '\C-s'
" stty -ixon
" Save with ctrl+s
" :update saves if there has been any changes to the file
nmap <c-s> :update<CR>
imap <c-s> <Esc>:update<CR>a

"2 :nmap <c-w> :q<CR>
" :imap <c-w> <Esc>:q<CR>

" Use space as leader key
nnoremap <SPACE> <Nop>
nmap <Space> <Leader>

nmap <Leader>r :LspRename<CR>
nmap <Leader>R :LspReferences<CR>
nmap <Leader>w :q<CR>
nmap <Leader>n :NERDTree<CR>

" spelling
nmap <Leader>s :setlocal spell spelllang=sv_se<CR>
nmap <Leader>f 1z=

nnoremap <Leader>p :CtrlP<CR>

nnoremap <c-B> :make<CR>


