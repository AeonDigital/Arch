# 310 - Preparando o computador para iniciar pelo S/O instalado

Neste ponto o Linux já está instalado no seu dispositivo mas você não conseguirá dar boot nele.  
Note, você ainda está no instalador do **Arch** e tudo o que você fez foi **de fora**.  
No final desta simples etapa você irá, pela primeira vez, **entrar** na sua instalação.



&nbsp;

## 310.1 - Criando o ``fstab``

O arquivo ``fstab`` é um arquivo de texto que serve para indicar ao sistema operacional onde estão 
as partições e onde cada qual está montada.  
Você pode usar o aplicativo ``genfstab`` que acompanha o instalador do **Arch** para criar o 
arquivo de uma forma correta e segura.

Use o comando abaixo:

``` shell
  genfstab -U -p /mnt >> /mnt/etc/fstab
```



&nbsp;

## 310.2 - Faça o "switch" para o root do novo sistema

Finalmente, a partir da execução do comando abaixo você **entra** na instalação efetuada e seus 
comandos serão realizados pelo mesmo e não mais pelo instalador do **Arch**.

``` shell
  arch-chroot /mnt
```
