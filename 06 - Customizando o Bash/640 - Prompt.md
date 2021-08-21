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
  \nnn  Caracter ASCII relativo ao "nnn"
  \\    Contrabarra
  \[    Begin a sequence of non-printing characters. This could be used to embed a terminal 
        control sequence into the prompt. 
  \]    End a sequence of non-printing characters. 
</pre>


&nbsp;

## 640.2 - Usando cores

Abaixo segue a cópia dos padrões de definição que você pode utilizar.

<pre>
  # O exemplo abaixo está usando entidades HTML para representar os caracteres '&lt;' e '&gt;'.
  # Tenha em mente que é preciso substituir tais entidades pelos caracteres originais para que
  # o exemplo funcione corretamente.
  \e[FUNDO;ATTR;FONTEm
  \e[FUNDO;ATTR;FONTE&lt;r&gt;;FONTE&lt;g&gt;;FONTE&lt;b&gt;m
  
  - Exemplo
  \e[38;2;255m
</pre>

    FUNDO             | ATTR              | FONTE

    40 - Preto        | 00 - Nenhum       | 30 - Preto
    41 - Vermelho     | 01 - Negrito      | 31 - Vermelho
    42 - Verde        | 04 - Sublinhado   | 32 - Verde
    43 - Amarelo      | 05 - Piscar       | 33 - Amarelo
    44 - Azul         | 07 - Inversa      | 34 - Azul
    45 - Rosa         | 08 - Oculta       | 35 - Rosa/Púrpura
    47 - Azul Claro   |                   | 36 - Azul Claro
    48 - Branco       |                   | 37 - Branco 


Você pode usar a função ``printPallete`` disponível no script ``bash-function-pallete256.sh`` que
está no diretório ``/shell/etc`` deste tutorial para conhecer qual o código deve usar para cada uma
das 256 cores disponíveis caso esteja limitado a um ambiente de 8 bits.



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

### 640.3.1 - Padrões que eu curto

#### 640.3.1.1 - Monocolor
> $ rianna@archlinux : _
> PSTYLE01="\$ \u@\h : "


&nbsp;

#### 640.3.1.2 - Verde Clássico
##### 640.3.1.2.1 - Minimalista 1
> $ rianna@archlinux : _
> PSTYLE02A="\[\e[40;01;32m\]\$ \u@\h : \[\e[40;00;37m\]"


&nbsp;

##### 640.3.1.2.2 - Minimalista 2
> $ rianna@archlinux : _
> PSTYLE02B="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u@\h \[\e[40;01;36m\]: \[\e[40;00;37m\]"


&nbsp;

##### 640.3.1.2.3 - Minimalista 3
> $ rianna@archlinux : _
> PSTYLE02C="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;36m\] : \[\e[40;00;37m\]"



&nbsp;

#### 640.3.1.3 - Detalhado, com Prompt na próxima linha
##### 640.3.1.3.1 - Detalhado 1
> $ rianna@archlinux in ~/DirName/SubDir  
> &gt; _  
> PSTYLE03A="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;01;34m\]\076 \[\e[40;00;37m\]"


&nbsp;

##### 640.3.1.3.2 - Detalhado 2
> ┌── $ rianna@archlinux in ~/DirName/SubDir  
> └──╼ _  
> PSTYLE03B="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200 \[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\e[40;00;37m\]"


&nbsp;

##### 640.3.1.3.3 - Detalhado 3
> ┌── $ rianna@archlinux in ~/DirName/SubDir  
> └──&gt; _  
> PSTYLE03C="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200 \[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\224\200\342\224\200\076 \[\e[40;00;37m\]"


&nbsp;

Se você observou atentamente, notou que coloquei cada definição de prompt dentro de uma variável
diferente. Fiz isto para que todos fiquem definidos na sessão e possam ser alternados conforme
a preferência.
