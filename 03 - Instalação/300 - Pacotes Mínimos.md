# 300 - Instalação das configurações iniciais e pacotes básicos

Ao final do passo anterior o básico do básico está feito para você começar a efetivamente montar
seu S/O. A partir de agora você irá personalizá-lo conforme seu gosto.

Ao longo deste passo serão feitas descrições de instalações que EU, baseada nas informações
colhidas pelos tutoriais, considero realmente mínimos e/ou interessantes de serem instaladas.

O primeiro passo é instalar uma coleção de pacotes **basicão** para começar esta etapa.
Com o comando abaixo, o grupo ``base`` terá seus pacotes listados e enumerados e o prompt aguardará
que você indique o número de cada item que deve ser instalado.

``` shell
  pacstrap -i /mnt base
```


Abaixo está a relação de pacotes que estarão disponíveis [em 2019-10-06]. 

[x] [ 1] bash (v5.0.009-1)                      The GNU Bourne Again shell
    [ 2] bzip2 (v1.0.8-2)                       ! A high-quality data compression program
    [ 3] coreutils (v8.31-1)                    ! The basic file, shell and text manipulation utilities of the GNU operating system
    [ 4] file (v5.37-2)                         File type identification utility
    [ 5] filesystem (v2019.05-2)                ! Base Arch Linux files
    [ 6] findutils (v4.7.0-1)                   ! GNU utilities to locate files
    [ 7] gawk (v5.0.1-1)                        ! GNU version of awk
    [ 8] gcc-libs (v9.1.0-2)                    ! Runtime libraries shipped by GCC
    [ 9] gettext (v0.20.1-2)                    > GNU internationalization library [grub]
    [10] glibc (v2.29-4)                        ! GNU C Library
    [11] grep (v3.3-1)                          ! A string search utility
    [12] gzip (v1.10-1)                         ! GNU compression utility
    [13] iproute2 (v5.2.0-1)                    > IP Routing Utilities  [network-manager-applet > networkmanager]
    [14] iputils (v20190709-1)                  Network monitoring tools, including ping
    [15] licenses (v20181104-1)                 Standard licenses distribution package
[x] [16] pacman (v5.1.3-1)                      A library-based package manager with dependency support
    [17] pciutils (v3.6.2-1)                    PCI bus configuration space access library and tools
    [18] procps-ng (v3.3.15-1)                  Utilities for monitoring your system and its processes
    [19] psmisc (v23.2-1)                       Miscellaneous procfs tools
[x] [20] sed (v4.7-1)                           GNU stream editor
    [21] shadow (v4.7-2)                        ! Password and account management tool suite with support for shadow files and PAM
    [22] systemd                                ! System and service manager
[x] [23] systemd-sysvcompat (v243.0-1)          sysvinit compat for systemd
    [24] tar (v1.32-1)                          > Utility used to store, backup, and transport files [network-manager-applet]
    [25] util-linux (v2.34-3)                   Miscellaneous system utilities for Linux
    [26] xz                                     ! Library and command line tools for XZ and LZMA compressed files
[x] [27] linux (v5.3.arch1-1)                   The Linux kernel and modules

Os itens cuja descrição é precedida de um ``!`` são aqueles em que a instalação será feita como 
dependência de um dos que estão selecionados.
Já os itens cuja descrição é precedida de um ``>`` são instalados como dependência de um ou outro 
pacote recomendado ao longo deste tutorial.


Para maiores informações visite a relação oficial em:
> https://www.archlinux.org/groups/x86_64/base/

Os itens marcados com [x] são considerados realmente essenciais e deveriam ser mantidos na sua 
instalação.



## 300.1 - Pacote extremamente mínimo

Com estes itens você instala o Arch Linux com o mínimo possível e pode seguir o tutorial. Neste 
momento você ainda não conseguirá dar um boot e nem acessar a internet.

``` shell
  # Para a coleção "base" a partir de 2019-10-06
  Enter a selection (default=all): 1 16 20 23 27

  # OU, use o comando abaixo
  pacstrap -i /mnt base bash pacman sed systemd-sysvcompat linux
```

Para a seleção feita a partir de 2019-10-06 será perguntado sobre qual dependência você deseja 
instalar para uma outra dependência chamada ``initramsf``, selecione o ``mkinitcpio``.



## 300.2 - Pacotes recomendados

Se você quiser se antecipar a este tutorial, segue uma orientação de quais pacotes serão 
necessários para uma instalação mínima +:


- sudo                      : se você não sabe para que serve, você não deveria estar aqui.
- grub                      : para configurar o boot em BIOS.
- grub-efi-x86_64           : para configurar o boot em UEFI.
- efibootmgr                : para configurar o boot em UEFI.
- network-manager-applet    : para configurar a internet.
- wireless_tools            : para configurar a internet sem fio.
- wpa_supplicant            : para configurar a internet.
- vim                       : editor de arquivos.
- sshfs                     : pra dar acesso SSH ao computador onde está sendo instalado o Arch.
- wget                      : para fazer downloads "avulsos".

Estes aqui eu recomendo mas eu mesma não os usei ainda.
Eles são usados para compilar e instalar programas/pacotes de forma avulsa (sem o ``pacman`` ou 
``apt-get`` por exemplo).
- gcc                       : compilador ``c``.
- make                      : instalador para pacotes avulsos.



``` shell
  pacstrap -i /mnt base bash pacman sed systemd-sysvcompat linux sudo grub network-manager-applet
  wireless_tools wpa_supplicant vim sshfs wget gcc make
```
