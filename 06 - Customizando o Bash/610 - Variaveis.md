# 610 - Variáveis

Configurando adequadamente as variáveis do seu terminal será possível que ele fique mais produtivo
para o seu tipo e ritmo de trabalho.

Abaixo seguem sugestões de configurações.

``` .bashrc
  ## Variáveis de controle
  HISTCONTROL=ignoreboth
  HISTSIZE=256
  HISTTIMEFORMAT="%F %T: "
```
  Conheça mais variáveis com o link indicado abaixo:
  https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html


Você pode também definir seu próprio set de variáveis caso precise para agilizar algum 
processamento.
Uma vez definida, a variável pode ser acessada usando um prefixo ``$``.

Exemplo de definição e uso:

``` shell
  NOME="Rianna"
  echo $NOME
  Rianna
```
