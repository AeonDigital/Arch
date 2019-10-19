# 230 - Montando as Partições

As partições são espaços logicamente separados dentro de uma unidade de armazenamento. A criação
de cada qual conta com a especificação de qual tamanho é destinada a elas e definindo o tipo de
sistema de arquivos que ela deve trabalhar.
O Sistema de Arquivos é efetivamente iniciado com os comandos do passo anterior mas as partições
ainda não estão prontas para uso pois o sistema não possui um **mapeamento** para elas.

Assim como no passo anterior, para evitar confusão, o tutorial está dividido em ``UEFI`` e 
``BIOS``. Apesar dos comandos e funções usadas serem quase iguais.



## 230.1 - [UEFI]
### 230.1.1 - Partição ``/`` (root)

Esta deve ser a primeira partição a ser montada pois ela é a raiz da estrutura que será usada pelo 
S/O e em cima dela é que as demais partições serão montadas.

O comando abaixo **mapeia** a partição para dentro do diretório ``mnt``.

``` shell
  mount /dev/sda2 /mnt
```

Após esta montagem inicial, você precisará criar algumas pastas especiais que serão usadas
posteriormente pelo S/O. Para isto use os seguintes comandos:

``` shell
  mkdir /mnt/boot 
  mkdir /mnt/boot/efi
  mkdir /mnt/home
```



### 230.1.2 - Partição de Boot

Monte a partição de boot em ``/mnt/boot/efi``

``` shell
  mount /dev/sda1 /mnt/boot/efi
```



### 230.1.2 - Partição ``/home``

Monte a partição ``home`` em ``/mnt/home``

``` shell
  mount /dev/sda3 /mnt/home
```



### 230.1.3 - Partição para o ``swap``

A partição ``swap`` é iniciada, não exatamente montada.

``` shell
  swapon /dev/sda4
```





## 230.2 - [BIOS]
### 230.2.1 - Partição ``/`` (root)

Esta deve ser a primeira partição a ser montada pois ela é a raiz da estrutura que será usada pelo 
S/O e em cima dela é que as demais partições serão montadas.

O comando abaixo **mapeia** a partição para dentro do diretório ``mnt``.

``` shell
  mount /dev/sda1 /mnt
```

Após esta montagem inicial, você precisará criar algumas pastas especiais que serão usadas
posteriormente pelo S/O. Para isto use os seguintes comandos:

``` shell
  mkdir /mnt/boot 
  mkdir /mnt/home
```



### 230.2.2 - Partição ``/home``

Monte a partição ``home`` em ``/mnt/home``

``` shell
  mount /dev/sda2 /mnt/home
```



### 230.12.3 - Partição para o ``swap``

A partição ``swap`` é iniciada, não exatamente montada.

``` shell
  swapon /dev/sda3
```
