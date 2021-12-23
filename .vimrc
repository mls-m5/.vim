" On first checkout remember to symlink with
" ln -s ~/.vim/.vimrc ~/.vimrc

" Remove the standard vim startup screen
set shm+=I

" Pathogen is a plugin that loads all plugins from folder "bundle"
execute pathogen#infect()
syntax on
filetype plugin indent on

" Oblivion color scheme
colorscheme aldmeris

" https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
" Remember to add the following to ~/.bash_profile or ~/.bashrc
" To prevent the terminal to catch the ctrl+s
" bind -r '\C-s'
" stty -ixon

" Save with ctrl+s
" :update saves if there has been any changes to the file
:nmap <c-s> :update<CR>
:imap <c-s> <Esc>:update<CR>a

:nmap <c-w> :q<CR>
:imap <c-w> <Esc>:q<CR>

" Clang format
function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
 
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()


" Replace tabs with 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" Use matmake as standard
set makeprg=matmake2\ -t\ gcc-debug

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

" Use space as leader key
nnoremap <SPACE> <Nop>
map <Space> <Leader>

nmap <Leader>r :LspRename<CR>
nmap <Leader>R :LspReferences<CR>



