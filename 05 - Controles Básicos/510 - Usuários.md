# 510 - Usuários

Uma vez que você compreendeu como funciona o sistema de permissões de uso para arquivos e 
diretórios dentro de sistemas Linux, agora você entenderá melhor como criar e gerenciar os 
usuários do seu sistema.


**IMPORTANTE**  
Todos os usuários no Linux possuem um ``User ID`` e um ``Group ID``, ambos identificados com 
numeros únicos chamados respectivamente ``UID`` e ``GID``.

**IMPORTANTE**  
Sempre que um novo usuário é criado, um grupo de mesmo nome será também criado e o novo usuário
passará a fazer parte de seu próprio grupo.



Apenas por curiosidade.  
Se você quiser conhecer todos os usuários existentes no seu sistema use o comando abaixo.

``` shell
  cut -d: -f1 /etc/passwd | sort
```



&nbsp;

## 510.1 - Criando usuários

O comando para criar novos usuários é o ``adduser``.  
Segue abaixo as instruções de uso do mesmo.

```
  adduser [opções] [username]
```

Algumas das opções são:

* -c ou --comment     : Utilizado para inserir um comentário ou o nome completo do usuário no 
                        momento em que estiver criando a conta do usuário.
* -d ou --home        : Cria o diretório do usuário onde o administrador quiser no momento da 
                        criação da conta.
* -e ou --expiredate  : Definição da data de expiração da conta do usuário, formato ano-mes-dia.
* -g ou --gid         : Nome do grupo ou GID do grupo que será padrão na criação do usuário.
* -G ou --groups      : O usuário poderá fazer parte de outros grupos sem alterar o grupo padrão.
* -M                  : Cria o usuário mas não cria o diretório HOME
* -m ou --create-home : Cria o HOME do usuário com base no SKEL, ou seja o HOME irá conter toda 
                        estrutura definida em /etc/skel.
* -o ou --non-unique  : Permite criar um usuário com o ID duplicado.
* -s ou --shell       : Define o shell do usuário.


**OBSERVAÇÃO**  
Note que, se você não especificar um grupo padrão (opção ``-g``), será criado um grupo com o mesmo 
nome do usuário e este será seu grupo padrão.


**EXEMPLOS**

``` shell
  #Cria o usuário
  adduser [username]

  #Cria o usuário com comentário
  adduser -c "Nome completo" [username]

  #Cria o usuário definindo o HOME e a data em que a conta irá expirar.
  adduser -d /tmp/[username] -e 2000-10-10 [username]

  #Cria o usuário em outro grupo - supondo que há no meu sistema um grupo chamado "cpd".
  adduser -g cpd [username]

  #Cria o usuário inserindo ele em outros grupos sem alterar o seu grupo padrão.
  adduser -G cpd [username]

  #Cria o usuário sem diretório HOME
  adduser -M [username]

  #Cria o usuário com o padrão definido no /etc/skel
  adduser -m [username]

  #Cria o usuário com o mesmo UID de um usuário existente no sistema 
  #Imaginamos que há um usuário no sistema cujo UID dele é 500.
  adduser -o --uid 500 [username]

  #Cria um usuário definindo o shell padrão
  adduser [username] -s /bin/bash

  #Cria o usuário mas ele não pode logar no sistema, por que não possui um shell
  adduser [username] -s /sbin/nologin
```



&nbsp;

### 510.1.1 - Alterando configurações do usuário

Você pode alterar configurações estipuladas na criação do usuário usando o comando ``usermod``.  
Segue abaixo as instruções de uso do mesmo.

``` shell
  usermod [opções] [username]
```

As opções são:

* -d    : Modifica o caminho do diretório home do usuário.
* -g    : Modifica o grupo do usuário.
* -c    : Modifica o comentário referente ao usuário.
* -s    : Modifica o Shell de comando que o usuário irá utilizar.
* -p    : Substitui a senha já criptografada do usuário.



&nbsp;

### 510.1.2 - Senha e acesso

Para definir uma senha de acesso para o usuário criado use o comando ``passws``.  
Segue abaixo as instruções de uso do mesmo.

``` shell
  passwd [username]
```

&nbsp;

Se você quiser, pode travar a conta de um usuário usando:

``` shell
  passwd -l [username]
``` 

&nbsp;

E para destravar a conta use:

```shell
  passwd -u [username]
```



&nbsp;

## 510.2 - Excluindo usuários

Para excluir usuários use o comando ``userdel``.
Segue abaixo as instruções de uso do mesmo.

```
  userdel [opções] [username]
```

As opções são:

* -f ou --force     : Força a remoção dos dados do usuário
* -r ou --remove    : Remove o diretório HOME e o spool do email


**EXEMPLOS**

``` shell
  #Remove o usuário
  userdel -r [username]
  #ou
  userdel -f [username]
```
