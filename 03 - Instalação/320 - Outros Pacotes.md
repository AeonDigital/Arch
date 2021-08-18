# 320 - Outros pacotes

Nesta etapa há vários pacotes e grupos de pacotes que são indicados para serem instalados.  
Se você reparou bem no que ocorreu no passo anterior deste tutorial, agora você está na sua nova instalação e passará 
a usar o ``pacman`` para efetuar a instalação dos novos pacotes.

**Atenção**  
Os pacotes obrigatórios são aqueles que você PRECISA instalar para conseguir dar um boot na sua máquina então não 
carecem de especulação sobre sua real necessidade.  
Os demais podem mesmo variar do uso que você quer dar para a sua máquina e também pela sua preferência por um ou outro 
aplicativo para resolver cada quesito que você julga importante.



&nbsp;

## 320.1 - grub [obrigatório]

O ``grub`` gerencia o boot do sistema então é necessário para que você consiga dar boot.  
Atente para a necessidade específica de cada tipo de placa mãe (BIOS e UEFI).

``` shell
  pacman -S grub-efi-x86_64 efibootmgr          [UEFI]
  pacman -S grub                                [BIOS]
```



&nbsp;

## 320.2 - Pacotes para habilitar internet [opcional]

``` shell
  pacman -S network-manager-applet wireless_tools wpa_supplicant
```



&nbsp;

## 320.3 - Pacotes recomendados

Ao menos 1 editor é necessário para conseguir se virar, recomendo o ``vim``.  
Se você for precisar se conectar a seu dispositivo por um outro computador, aconselho a instalação do ``sshfs``.

``` shell
  # Os itens abaixo 
  # então!
  pacman -S sudo
  
  # Editor
  pacman -S vim

  # permite conexão ssh
  pacman -S sshfs        

  # permite realizar downloads
  pacman -S wget

  # compilador c/c++
  pacman -S gcc

  # instalador
  pacman -S make
```


Para listar os pacotes instalados use:
``` shell
  pacman -Q -e | less
```
  O ``less`` permitirá paginar o resultado.
  Você pode adicionar o parametro ``-e`` para listar apenas os pacotes instalados explicitamente 
  ou ``-d`` para listar apenas as dependências.
