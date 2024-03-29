# 620 - Aliases

Você pode também criar seus próprios apelidos para comandos que você usa com frequencia.
Abaixo segue uma lista de sugestões.

``` .bashrc
  ## Aliases de comandos
  ### Lidando com arquivos e diretórios
  alias copy="cp"
  alias move="mv"
  alias remove="rm"
  alias removeall="rm -R"
  alias makefile="touch"
  alias makedir="mkdir -pv"

  ### Listando arquivos e diretórios
  alias ls="ls --color=always"
  alias list="ls -l --group-directories-first"
  alias listall="ls -la --group-directories-first"
  alias listdir="ls -ld */"
  alias dir="dir --color=auto"
  alias vdir="vdir --color=auto"
  alias grep="grep --colour=always"

  ### Navegando entre os diretórios
  alias cd..="cd .."
  alias tohome="cd ~"

  ### Procurando arquivos e mostrando informações
  alias whereis="find / -name"
  alias whereisci="find / -iname"
  alias whereisdir="find / -type d -name"
  alias whereisdirci="find / -type d -iname"
  alias showmyip="curl ipinfo.io/ip"
  alias showdate="date +'%A, %d de %B - %Y [%T (%Z)]'"

  ### Redefinindo o bash
  alias reloadbash="source ~/.bashrc"
  alias restartbash="exec bash"
```
