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


