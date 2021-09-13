# 640 - Configurando o Prompt

Esta é uma das partes mais interessantes pois permite que você organize as informações que aparecem
no prompt de comando a cada linha executada.  

Uma das variáveis de configuração do ``bash`` é a ``PS1``. Ela geralmente é definida no arquivo
``/etc/bash.bachrc`` e fica disponível para todos os usuários. Nela estão as instruções que compõe
o prompt demonstrado no terminal.  

Exemplo:
``` /etc/bash.bachrc
  PS1="\$ \u@\h : "
```

Isto mostrará um prompt com as seguintes informações:  
  $ usuario@hostname:  
  ou  
  $ rianna@archlinux:  

Se você entendeu bem o tópico ``Como Configurar o Bash`` sabe que pode usar o seu arquivo
``~/.bash`` para redefinir esta variável. Como ele será lido por último, o valor que você definir
desta forma será aquele que será usado pelo seu usuário sempre que fizer o login.



&nbsp;

## 640.1 - Comandos de personalização

Os seguintes comandos podem ser usados para configurar o prompt:  

<pre>
  \a    Caracter invisível, emite um "beep" quando usado
  \d    Data no formato "Dia Mês Data"
  \D{format}  The format is passed to strftime(3) and the result is inserted in the prompt string;
              an empty format results in a locale-specific time representation.
              The braces are required
  \e    Caracter de escape
  \h    Hostname sem o grupo de trabalho, até o primeiro "."
  \H    Hostname com o grupo de trabalho .
  \j    The number of jobs currently managed by the shell.
  \l    The basename of the shell's terminal device name.
  \n    Nova linha
  \r    Retorno de "carro" (retorna para o início da linha)
  \s    Nome do shell
  \t    Horas no formato (24-horas) HH:MM:SS
  \T    Horas no formato (12-horas) HH:MM:SS
  \@    Horas no formato AM/PM
  \A    Horas no formato (24-horas) HH:MM
  \u    Usuário que está usando o shell
  \v    Versão do bash
  \V    Versão + patch do bash
  \w    Caminho completo do diretório atual
        com a abreviação de $HOME com um ~ (usado com a variável $PROMPT_DIRTRIM)
  \W    Nome do diretório atual
        com a abreviação de $HOME com um ~
  \!    O número deste comando no histórico
  \#    O número deste comando
  \$    Simbolo # (caso root) ou $ (outros usuários)
  \nnn  Caracter ASCII relativo ao "nnn" (veja as tabelas de caracteres no apendice)
  \\    Contrabarra
  \[    Begin a sequence of non-printing characters. This could be used to embed a terminal
        control sequence into the prompt.
  \]    End a sequence of non-printing characters.
</pre>


&nbsp;

## 640.2 - Usando cores e caracteres unicode

Use as regras expostas no item 604 para entender como se dá a estilização das cores de textos no
Bash.  

Para o uso de caracteres unicode é aconselhado usar o código octal que representa cada um dos 
glifos que você deseja representar.  

Use a função ``printCharTable`` do projeto ``myShellEnv`` para conhecer os códigos octais de todos
os 256 caracteres disponíveis no seu terminal (com a fonte que está sendo usada no momento).  
Você também pode usar o comando ``showkey -a`` para conhecer os códigos correspondentes a cada 
tecla de caracter do seu teclado.


**Obs**  
Para evitar problemas de interpretação do tamanho do seu prompt no Bash, quando utilizar cores ou
caracteres não ascii, acostume-se a envolver o código da cor e dos caracteres não ascii em
volta dos códigos ``\[`` e ``\]``.  



&nbsp;

## 640.3 - Efetuando testes

Você pode armazenar o estado atual da variável ``PS1`` criando uma variável de sessão para isto.

``` shell
  TMPPS1=$PS1
  echo $TMPPS1
```

Uma vez que o valor inicial está salvo, agora você pode alterar o valor de ``PS1`` e testar
configurações até chegar em alguma que lhe agrade.



&nbsp;

### 640.3.1 - Padrões de prompt que eu curto

Substitua os ``placeholders`` pelos códigos das cores que você deseja usar para cada um dos estilos
apresentados abaixo.  


&nbsp;

#### 640.3.1.1 - Estilo simples

> $ rianna@archlinux : _  
> PS1='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] :[[NONE]]\040'


&nbsp;

#### 640.3.1.2 - Estilo nova linha 01

> $ rianna@archlinux in ~/DirName/SubDir  
> \> _  
>   
> PS1='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n\076[[NONE]]\040'


&nbsp;

#### 640.3.1.3 - Estilo nova linha 02

> ┌── $ rianna@archlinux in ~/DirName/SubDir  
> └─> _  
>  
> PS1='[[DIRECTORY]]\[\342\224\214\]\[\342\224\200\]\[\342\224\200\] [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\224\]\[\342\224\200\]\076[[NONE]]\040'


&nbsp;

#### 640.3.1.4 - Estilo nova linha 03

> ┌── $ rianna@archlinux in ~/DirName/SubDir  
> └─╼ _  
>  
> PS1='[[DIRECTORY]]\[\342\224\214\]\[\342\224\200\]\[\342\224\200\] [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\224\]\[\342\225\274\][[NONE]]\040'
