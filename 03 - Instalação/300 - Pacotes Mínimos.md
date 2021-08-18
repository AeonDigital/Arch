# 300 - Instalação das configurações iniciais e pacotes básicos

Ao final do passo anterior o básico do básico está feito para você começar a efetivamente montar seu S/O. A partir de 
agora você irá personalizá-lo conforme seu gosto.

Ao longo deste passo serão feitas descrições de instalações que EU, baseada nas informações colhidas pelos tutoriais, 
considero realmente mínimos e/ou interessantes de serem instaladas.

O primeiro passo é instalar uma coleção de pacotes **basicão** para começar esta etapa.  
Com o comando abaixo, o grupo ``base`` terá seus pacotes listados e enumerados e o prompt aguardará que você indique o 
número de cada item que deve ser instalado.

``` shell
  pacstrap -i /mnt base
```


Abaixo está a relação de pacotes que estarão disponíveis [a partir de 2019-11-13]. 

<pre>
[x] [ 1] bash ................... The GNU Bourne Again shell  
    [ 2] bzip2 .................. ! A high-quality data compression program  
    [ 3] coreutils .............. ! The basic file, shell and text manipulation utilities of the GNU operating system  
    [ 4] file ................... ! File type identification utility  
    [ 5] filesystem ............. ! Base Arch Linux files  
    [ 6] findutils .............. ! GNU utilities to locate files  
    [ 7] gawk ................... ! GNU version of awk  
    [ 8] gcc-libs ............... ! Runtime libraries shipped by GCC  
    [ 9] gettext ................ > GNU internationalization library [grub]  
    [10] glibc .................. ! GNU C Library  
    [11] grep ................... ! A string search utility  
[x] [12] gzip ................... GNU compression utility  
    [13] iproute2 ............... > IP Routing Utilities  [network-manager-applet > networkmanager]  
    [14] iputils ................ Network monitoring tools, including ping  
    [15] licenses ............... Standard licenses distribution package  
[x] [16] pacman ................. A library-based package manager with dependency support  
    [17] pciutils ............... PCI bus configuration space access library and tools  
    [18] procps-ng .............. > Utilities for monitoring your system and its processes  
    [19] psmisc ................. Miscellaneous procfs tools  
[x] [20] sed .................... GNU stream editor  
    [21] shadow ................. ! Password and account management tool suite with support for shadow files and PAM  
    [22] systemd ................ ! System and service manager  
[x] [23] systemd-sysvcompat ..... sysvinit compat for systemd  
    [24] tar .................... > Utility used to store, backup, and transport files [network-manager-applet]  
    [25] util-linux ............. > Miscellaneous system utilities for Linux  
    [26] xz ..................... ! Library and command line tools for XZ and LZMA compressed files  
[x] [27] linux .................. The Linux kernel and modules  
</pre>

Os itens cuja descrição é precedida de um ``!`` são aqueles em que a instalação será feita como dependência de um dos 
que estão selecionados.
Já os itens cuja descrição é precedida de um ``>`` são instalados como dependência de um ou outro pacote recomendado 
ao longo deste tutorial.


Para maiores informações visite a relação oficial em:
> https://archlinux.org/packages/core/any/base/

Os itens marcados com [x] são considerados realmente essenciais e deveriam ser mantidos na sua instalação.



&nbsp;

## 300.1 - Pacote extremamente mínimo

Com estes itens você instala o Arch Linux com o mínimo possível e pode seguir o tutorial. Neste momento você ainda não 
conseguirá dar um boot e nem acessar a internet.

``` shell
  # Para a coleção "base" a partir de 2019-11-13
  Enter a selection (default=all): 1 12 16 20 23 27
 
  # OU, use o comando abaixo
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux
```

Para a seleção feita a partir de 2019-11-13 será perguntado sobre qual dependência você deseja 
instalar para uma outra dependência chamada ``initramsf``, selecione o ``mkinitcpio``.



&nbsp;

## 300.2 - Pacotes recomendados

Se você quiser se antecipar a este tutorial, segue uma orientação de quais pacotes serão 
necessários para uma instalação mínima +:

<pre>
- sudo .................... : se você não sabe para que serve, você não deveria estar aqui.
- grub .................... : para configurar o boot em BIOS.
- grub-efi-x86_64 ......... : para configurar o boot em UEFI.
- efibootmgr .............. : para configurar o boot em UEFI.
- network-manager-applet .. : para configurar a internet.
- wireless_tools .......... : para configurar a internet sem fio.
- wpa_supplicant .......... : para configurar a internet sem fio.
- vim ..................... : editor de arquivos.
- sshfs ................... : pra dar acesso SSH ao computador onde está sendo instalado o Arch.
- wget .................... : para fazer downloads "avulsos".
- less .................... : facilita a visualização de textos no terminal.
</pre>

Estes aqui eu recomendo mas eu mesma não os usei ainda.
Eles são usados para compilar e instalar programas/pacotes de forma avulsa (sem o ``pacman`` ou 
``apt-get`` por exemplo).
- gcc                       : compilador ``c``.
- make                      : instalador para pacotes avulsos.


&nbsp;

### Pacote sem Wireless, com Internet e acesso SSH

``` shell
  # UEFI
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo grub grub-efi-x86_64 efibootmgr network-manager-applet vim sshfs wget less

  # BIOS
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo grub network-manager-applet vim sshfs wget less
```


&nbsp;

### Pacote com Wireless, com Internet e acesso SSH

``` shell
  # UEFI
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo grub grub-efi-x86_64 efibootmgr network-manager-applet wireless_tools wpa_supplicant vim sshfs wget less

  # BIOS
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo grub network-manager-applet wireless_tools wpa_supplicant vim sshfs wget less
```
