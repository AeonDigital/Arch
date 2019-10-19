"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Geral
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Define quantas linhas de histórico de comandos devem ser guardadas
set history=100

" Recarrega o arquivo caso ele seja alterado por outra parte
set autoread

" Define UTF-8 como o encode padrão 
set encoding=utf8

" Define "Unix" como o tipo padrão de tipo de arquivo
set fileformat=unix



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Arquivos de backup e swap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Desabilita estes arquivos
set nobackup
set nowb
set noswapfile



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface do usuário
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mostra numeração de linhas
set nu

" Mostra o modo em que estamos
set showmode

" Mostra no status os comandos inseridos
set showcmd

" Mostra a posição atual do cursor (coluna|linha).
set ruler

" Altura da linha de comando
set cmdheight=1

" Sempre mostra a linha de status
set laststatus=2

" Formata a linha de status
" use o comando ':help statusline' para conhecer outras opções de 
" formatação para a linha de status
set statusline=%F%m\ %=Linha:\ %l\/%L\ Coluna:\ %c



" Destaca com cores os termos procurados.
set nohlsearch

" Torna as buscas case-insensitive
set ignorecase

" Torna as buscas case-sensitive quando houver presença de letras
" maiúsculas na busca
set smartcase

" Define a quantidade de linhas que são movidas ao alterar o 
" cursor movendo verticalmente
set so=7

" Destaca os delimitadores "{,[,(,),],}" quando o cursor está sobre 
" um deles
set showmatch 

" Relacionado com o item anterior
" Define quantos décimos de segundo até o destaque ocorrer
set mat=2



" Desabilita os sons de alerta quando ocorrem erros.
set noerrorbells
set novisualbell
set t_vb=
set tm=500



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Texto tabulação e identação
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Define que devem ser usados espaços ao invés de tabulação.
set expandtab

" Define o tamanho que as tabulações devem ser representadas
set shiftwidth=4
set tabstop=4

" Usa o valor definido em 'shiftwidth' ao invés do de 'tabstop'
" para o início das linhas
set smarttab

" Habilita a auto identação
set autoindent

" Quebra automática de linhas
set nowrap



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cores e fontes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Habilita cores dependendo dos esquemas existentes na instalação
" e do tipo de arquivo aberto
syntax enable

" Habilita a paleta de 256 cores num terminal Gnome
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Habilita o esquema de cores "desert" se possível.
try
    colorscheme desert
catch
endtry



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Notas sobre mapeamentos
" Tecla            : Tecla mapeada
" <CR>             : Enter
" <ESC>            : Escape
" <LEADER>         : normalmente \
" <BAR>            : | pipe 
" <CWORD>          : Palavra sob o cursor
" <CFILE>          : Arquivo sob o cursor
" <CFILE><         : Arquivo sob o cursor sem extensão
" <SFILE>          : Conteúdo do arquivo sob o cursor
" <LEFT>           : Salta um caractere para esquerda
" <UP>             : Equivale clicar em 'seta acima'
" <M-F4>           : A tecla ALT -> M  mais a tecla F4
" <C-f>            : Control f
" <BS>             : Backspace
" <space>          : Espaço
" <TAB>            : Tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
