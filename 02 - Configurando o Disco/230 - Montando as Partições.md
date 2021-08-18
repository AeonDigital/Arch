# 230 - Montando as Partições

As partições são espaços logicamente separados dentro de uma unidade de armazenamento. A criação 
de cada qual conta com a especificação de qual tamanho é destinada a elas e definindo o tipo de 
sistema de arquivos que ela deve trabalhar.  
O Sistema de Arquivos é efetivamente iniciado com os comandos do passo anterior mas as partições 
ainda não estão prontas para uso pois o sistema não possui um **mapeamento** para elas.



&nbsp;

## 230.1 - Partição root; ``/``

Esta deve ser a primeira partição a ser montada pois ela é a raiz da estrutura que será usada 
pelo S/O e em cima dela é que as demais partições serão montadas.

O comando abaixo **mapeia** a partição para dentro do diretório ``mnt``.

``` shell
  mount /dev/sda3 /mnt
```

Após esta montagem inicial, você precisará criar algumas pastas especiais que serão usadas posteriormente pelo S/O. 
Para isto use os seguintes comandos:

``` shell
  mkdir /mnt/boot 
  mkdir /mnt/home
```



&nbsp;

## 230.2 - Partição EFI System ou Partição BIOS Boot

Monte a partição de boot em ``/mnt/boot``

``` shell
  mount /dev/sda1 /mnt/boot
```



&nbsp;

## 230.3 - Partição para o ``swap``

A partição ``swap`` é ativada, não exatamente montada.

``` shell
  swapon /dev/sda2
```



&nbsp;

## 230.4 - Partição home; ``/home`` (opcional)

Se existir, monte a partição ``home`` em ``/mnt/home``

``` shell
  mount /dev/sda4 /mnt/home
```
