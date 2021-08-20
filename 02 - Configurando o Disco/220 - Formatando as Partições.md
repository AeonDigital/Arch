# 220 - Criando o FileSystem

Neste momento as partições apenas existem de forma lógica no disco mas não estão prontas para uso.  
Cada partição precisa ser formatada respeitando o tipo que foi definida no passo anterior.



&nbsp;

## 220.1 - Criando as Partições
### 220.1.1 - [Apenas em UEFI] Partição EFI System

Esta partição precisa ser formatada em ``Fat32``, para isto, use o comando:

``` shell
  mkfs.fat -F32 /dev/sda1
```


&nbsp;

### 220.1.2 - [Apenas em Bios] Partição BIOS Boot

Esta partição precisa ser formatada em ``Fat32``, para isto, use o comando:

``` shell
  mkfs.fat -F32 /dev/sda1
```


&nbsp;

### 220.1.3 - Partição para o ``swap``

Esta partição deve ser formatada usando:

``` shell
  mkswap /dev/sda2
```


&nbsp;

### 220.1.4 - Partição root; ``/``

Esta partição pode ser formatado em ``ext4`` que é o formato padrão usado no mundo Linux.

``` shell
  mkfs.ext4 /dev/sda3
```


&nbsp;

### 220.1.5 - Partição home; ``/home`` (opcional)

Se existir, esta partição também pode ser formatado em ``ext4``.

``` shell
  mkfs.ext4 /dev/sda4
```



&nbsp;

## 230.2 - Criando um ``DUMP`` do seu sistema de partições (opcional)

Se você quiser, pode exportar o esquema de partições criado para ser mais fácil replicá-lo quando
desejar, ou mesmo, para automatizar processos.  
O comando abaixo irá exportar as informações de partições que compõe o seu disco e lhe permitirá
executar tudo de uma só vez conforme mostra o próximo tópico.

``` shell
  sfdisk -d /dev/sda > my-partitions.out
```



&nbsp;

## 230.3 - Usando um ``DUMP`` do seu sistema de partições (opcional)

Uma vêz que você tem um DUMP de seu sistema de partições que deseja usar em formato de arquivo
você pode utilizá-lo conforme o comando abaixo.

``` shell
  sfdisk -d /dev/sda < my-partitions.out
```
