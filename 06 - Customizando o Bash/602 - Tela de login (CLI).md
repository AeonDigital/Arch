# 602 - Configurando as informações na tela de login

As informações mostradas antes do login quando você acessa o Arch estão definidas em um arquivo
armazenado em ``/etc/issue``. Tipicamente, trata-se de tudo o que aparece antes do cursor de
login de autenticação.  

Há um outro arquivo, armazenado em ``/etc/motd``, cujo conteúdo é mostrado imediatamente após
o login e imediatamente ANTES do ``shell`` do usuário ser iniciado.  

Na manipulação destes dois arquivos você pode gerar uma tela inicial para a máquina que está
sendo configurada.

&nbsp;

**FONTE**  
https://unix.stackexchange.com/questions/16255/how-can-i-change-whats-displayed-at-a-login-shell



&nbsp;

## 602.1 - Comandos para a configuração 

Use os comandos abaixo para configurar o seu sistema:

<pre>
  \b -- Baudrate of the current line.
  \d -- Data atual.
  \s -- Nome do sistema, o nome do Sistema Operacional.
  \l -- Nome do TTY (TeleTYpewriter).
  \m -- Arquitetura da máquina, ex. i486
  \n -- Nome da máquina, também chamado de hostname.
  \o -- Nome do domínio da máquina.
  \r -- Número da versão do Sistema Operacional, ex. 1.1.9.
  \t -- Horario atual.
  \u -- Número de usuários atualmente logados.
  \U -- Mesmo que \u mas usa a versão escrita como: "1 user" ou "x users".
  \v -- Versão do Sistema Operacional, ex. the build-date etc.
</pre>



&nbsp;

## 602.2 - Modelo de configuração 

Segue um exemplo de configuração para a 'tela de login' do sistema.


``` /etc/issue
      Arch \s (\m)
        :: Version \r
        :: Build \v
        :: TeleTYpewriter \l
  ____________________________________________________________________

                             AeonDigital
                      http://aeondigital.com.br
  ____________________________________________________________________

                              Machine
                  Name: \n
                Domain: \o
                  Date: \d  \t
                 Users: \u
  ____________________________________________________________________


```
