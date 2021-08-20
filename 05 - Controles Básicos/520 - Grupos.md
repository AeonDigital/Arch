# 520 - Grupos

No Linux os grupos são um mecanismo para gerenciar uma coleção de usuários do sistema.



**IMPORTANTE**  
Todos os usuários no Linux possuem um ``User ID`` e um ``Group ID``, ambos identificados com 
numeros únicos chamados respectivamente ``UID`` e ``GID``.

**IMPORTANTE**  
Sempre que um novo usuário é criado, um grupo de mesmo nome será também criado e o novo usuário
passará a fazer parte de seu próprio grupo.



&nbsp;

## 520.1 - Criando grupos

O comando para criar novos usuários é o ``addgroup``.  
Segue abaixo as instruções de uso do mesmo.

```
  addgroup [opções] [groupname]
```

Algumas das opções são:

* -c ou --comment     : Utilizado para inserir um comentário ou descrição para o grupo.
* -e ou --expiredate  : Definição da data de expiração da conta dos usuários deste grupo, 
                        formato ano-mes-dia.
* -g ou --gid         : Usando esta opção você pode definir o GID do grupo.


&nbsp;

**EXEMPLOS**

``` shell
  #Cria um grupo
  addgroup [groupname]
```



&nbsp;

### 520.1.1 - Alterando configurações do grupo

Você pode alterar configurações estipuladas na criação do grupo usando o comando ``groupmod``.  
Segue abaixo as instruções de uso do mesmo.

``` shell
  groupmod [opções] [groupname]
```

As opções são:

* -c ou --comment     : Modifica o comentário referente ao usuário.
* -e ou --expiredate  : Modifica a data de expiração do grupo.
* -g ou --gid         : Modifica o grupo do usuário.
* -n                  : Modifica o nome do grupo.



&nbsp;

### 520.2.1 - Adicionando usuários em um grupo

Para adicionar usuários em um grupo específico use o comando ``adduser`` já descrito anteriormente
na parte de Usuários.

``` shell
  adduser [username] [groupname]
```



&nbsp;

### 520.2.2 - Removendo usuários de um grupo

Para remover usuários de um grupo específico use o comando ``deluser``.

``` shell
  deluser [username] [groupname]
```



&nbsp;

### 520.3 - Conhecendo os grupos e usuários do sistema

Se você quiser conhecer todos os grupos existentes no seu sistema use um dos comandos abaixo.

``` shell
  cat /etc/group

  cut -d: -f1 /etc/group | sort
```

Já se quiser conhecer todos os usuários de um determinado grupo pode usar o seguinte:

``` shell
  grep [groupname] /etc/group
```



&nbsp;

## 520.4 - Excluindo grupos

Para excluir grupos use o comando ``delgroup``.  
Segue abaixo as instruções de uso do mesmo.

```
  delgroup [groupname]
```
