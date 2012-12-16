"General {
    set textwidth=80
    set nocp "no vi compatibility
    set autochdir "always switch to the current file directory
    set wildmenu "turn on command line completion wild style
    set hlsearch "highlight search
    set incsearch "incremental search
    autocmd BufReadPost * set iskeyword=A-Z,a-z,160-255,48-57,',_
    autocmd BufWritePre * :%s/\s\+$//e
"}

"Indentation {
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set nojoinspaces
"    set tabstop=4
    set listchars=tab:>- "show tabs if :set list
    set autoindent
    filetype plugin indent on
"}

"Syntax settings {
    syntax on
    autocmd FileType *    set formatoptions=tcql
          \ nocindent comments&
    autocmd FileType c,cpp set formatoptions=croql
          \ cindent comments=sr:/*,mb:*,ex:*/,://
    set ofu=syntaxcomplete#Complete
"}

"UI {
    colorscheme elflord
    " popup menu colors
    hi Pmenu ctermbg=gray ctermfg=black
    hi PmenuSel ctermbg=black ctermfg=white

    set ruler
    set showmode
    set showcmd
    set number

    set laststatus=2 "show statusline
    set statusline=%f[%L][%{&ff}]%y[%p%%][%04l,%04v]

    set t_Co=256 "256 color mode
    "highlight long lines
    highlight OverLength ctermbg=234
    match OverLength /\%81v.*/

    set scrolloff=5 "5-5 lines top-bottom

    "supertab {
        let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-n>"
    "}
"}

"Key mappings {
    map <F3> :tabnext<CR>
    map <F2> :tabprevious<CR>
    map <F4> :tabnew<CR>

    "Insert date {
        function DateInsert()
               $read !date
        endfunction
        map <F12> :call DateInsert()<CR> \| :write<CR>
    "}

    map <F5> :setlocal spell! spelllang=hu<CR>
    map <F6> :setlocal spell! spelllang=en_us<CR>
    imap <c-n> <ESC>
"}

"C/C++ specific {
    ab #d #define
    ab #i #include
    ab #b /****************************************
    ab #e <Space>****************************************/
    ab #l /*----------------------------------------------*/

    "ctags {
        set tags+=./tags
        set tags+=~/.vim/tags/cpp

        map <F8> :!/usr/bin/ctags -R --c-kinds=+p --fields=+iaS --extra=+q<CR> <CR>
        let Tlist_Ctags_Cmd = "/usr/bin/ctags"
        let Tlist_WinWidth = 50
        map <F7> :TlistToggle<cr>
    "}

    "OmniCpp {
        let OmniCpp_NamespaceSearch = 2
        let OmniCpp_GlobalScopeSearch = 1
        let OmniCpp_ShowAccess = 1
        let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
        let OmniCpp_ShowScopeInAbbr = 0
        let OmniCpp_MayCompleteDot = 1 " autocomplete after .
        let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
        let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
        "let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
        "automatically open and close the popup menu / preview window
        "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menuone,menu,longest
    "}
"}

"Python specific {
    ab #!p #!/usr/bin/env python
    let g:pydiction_location = '/usr/share/pydiction/complete-dict'
    let g:pydiction_menu_height = 20
"}

