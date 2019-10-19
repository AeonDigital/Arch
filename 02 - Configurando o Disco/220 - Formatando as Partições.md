# 220 - Criando o FileSystem, Formatando e Montando as partições

Neste momento as partições apenas existem de forma lógica mas não estão prontas para uso.
Cada partição precisa ser formatada respeitando o tipo que foi definida no passo anterior.

Para evitar confusão, o tutorial está dividido em ``UEFI`` e ``BIOS``. Apesar dos comandos e 
funções usadas serem quase iguais.



## 220.1 - [UEFI]
### 220.1.1 - Criando o FileSystem
#### 220.1.1.1 - Partição de Boot

Esta partição precisa ser formatada em ``Fat32``, para isto, use o comando:

``` shell
  mkfs.fat -F32 /dev/sda1
```



#### 220.1.1.2 - Partição ``/`` (root)

Esta partição pode ser formatado em ``ext4`` que é o formato padrão usado no mundo Linux.

``` shell
  mkfs.ext4 /dev/sda2
```


#### 220.1.1.3 - Partição ``/home``

Esta partição também pode ser formatado em ``ext4``.

``` shell
  mkfs.ext4 /dev/sda3
```


#### 220.1.1.4 - Partição para o ``swap``

Esta partição deve ser formatada usando:

``` shell
  mkswap /dev/sda4
```





## 220.2 - [Bios]
### 220.2.1 - Criando o FileSystem
#### 220.2.1.2 - Partição ``/`` (root)

Esta partição pode ser formatado em ``ext4`` que é o formato padrão usado no mundo Linux.

``` shell
  mkfs.ext4 /dev/sda1
```


#### 220.2.1.3 - Partição ``/home``

Esta partição também pode ser formatado em ``ext4``.

``` shell
  mkfs.ext4 /dev/sda2
```


#### 220.2.1.4 - Partição para o ``swap``

Esta partição deve ser formatada usando:

``` shell
  mkswap /dev/sda3
```
