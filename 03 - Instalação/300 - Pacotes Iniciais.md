# 300 - Instalação dos pacotes iniciais

Ao final do passo anterior o básico do básico está feito para você começar a efetivamente montar
seu S/O. A partir de agora você irá personalizá-lo conforme seu gosto.

Ao longo deste passo serão feitas descrições de instalações que EU, baseada nas informações
colhidas até aqui, considero realmente mínimos e/ou interessantes de serem instaladas.

O primeiro passo é instalar uma coleção de pacotes **essenciais** para começar esta etapa.
Há uma coleção de pacotes chamados ``base`` que é disponibilizada pelo repositório oficial e que,
se usado irá instalar todos os pacotes listados abaixo.

``` shell
  pacstrap /mnt base
```

Na listagem abaixo estão relacionados todos os pacotes que serão instalados com a coleção ``base``.
Pela pesquisa e testes que fiz, identifiquei um subgrupo que seria considerado realmente essencial.
São aqueles que você só instalará se quiser o mínimo do mínimo.

**Obs:** Note que mesmo assim ocorrerá a instalação de pacotes que são dependências destes e que serão
instalados de qualquer forma.


- Os itens marcados com [x] são considerados realmente essenciais e deveriam ser mantidos na sua
instalação.
- Os itens cuja descrição é precedida de um ``!`` são aqueles em que a instalação será feita como
dependência de um dos que estão selecionados.
- Já os itens cuja descrição é precedida de um ``>`` são instalados como dependência de um ou outro
pacote ou são recomendados por motivos específicos ao longo deste tutorial.


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
    [14] iputils ................ > Network monitoring tools, including ping
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


Para maiores informações visite a relação oficial em:
> https://archlinux.org/packages/core/any/base/




&nbsp;

## 300.1 - Pacote essenciais

Com estes itens você instala o Arch Linux com o mínimo possível e pode seguir o tutorial. Neste
momento você ainda não conseguirá dar um boot e nem acessar a internet.

``` shell
  # Instale os itens essenciais com o comando a seguir:
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux
```

Para a seleção feita a partir de 2019-11-13 será perguntado sobre qual dependência você deseja
instalar para uma outra dependência chamada ``initramsf``, selecione o ``mkinitcpio``.



&nbsp;

## 300.2 - Pacotes necessários e recomendados

A coleção de pacotes listados abaixo são necessários para que sua máquina tenha o mínimo que normalmente
é requerido para que ela se torne útil para um usuário humano. Outros são recomendados por mim dada a
constância de seu uso no dia a dia (ao menos dentro da minha realidade).


<pre>
- sudo .................... : se você não sabe para que serve, você não deveria estar aqui.
- vim ..................... : editor de arquivos.
- sshfs ................... : pra dar acesso SSH ao computador onde está sendo instalado o Arch.
- less .................... : facilita a visualização de textos no terminal.
- wget .................... : para fazer downloads "avulsos" [eventualmente usado por outros pacotes].
- tzdata .................. : Fontes para trabalhar com fuso horário.
- pacman-contrib .......... : Scripts e ferramentas extras para sistemas pacman.
- grub .................... : para configurar o boot em BIOS.
- grub-efi-x86_64 ......... : para configurar o boot em UEFI.
- efibootmgr .............. : para configurar o boot em UEFI.
- network-manager-applet .. : para configurar a internet.
- wireless_tools .......... : para configurar a internet sem fio.
- wpa_supplicant .......... : para configurar a internet sem fio.
</pre>


&nbsp;

**Compilador C**

Já os usei eventualmente para compilar e/ou instalar programas/pacotes de forma avulsa (sem o
``pacman`` ou ``apt-get`` por exemplo).

<pre>
- gcc ..................... : compilador ``c``.
- make .................... : instalador para pacotes avulsos.
</pre>


&nbsp;

**Ferramentas de rede, segurança e afins**

Dependendo do caso você pode precisar destes aqui.

<pre>
- iputils.................. : Network monitoring tools, including ping.
- openssl ................. : Implementation of the SSL and TLS protocols.
</pre>



&nbsp;

### Minha instalação

``` shell
  # pack base
  #   bash gzip pacman sed systemd-sysvcompat linux
  #
  # pack mínimo
  #   sudo vim sshfs less wget tzdata pacman-contrib
  #
  # pack grub
  #   [UEFI]
  #   grub-efi-x86_64 efibootmgr
  #   [BIOS]
  #   grub
  #
  # pack internet
  #   [Wired]
  #   network-manager-applet
  #   [Wireless]
  #   network-manager-applet wireless_tools wpa_supplicant
  #
  # opcionais
  #   gcc make iputils openssl
  #


  # UEFI [wired]
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less wget tzdata pacman-contrib grub-efi-x86_64 efibootmgr network-manager-applet

  # UEFI [wireless]
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less wget tzdata pacman-contrib grub-efi-x86_64 efibootmgr network-manager-applet wireless_tools wpa_supplicant


  # BIOS [wired]
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less wget tzdata pacman-contrib grub network-manager-applet

  # BIOS [wireless]
  pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less wget tzdata pacman-contrib grub network-manager-applet wireless_tools wpa_supplicant


  # Opcionais
  pacstrap /mnt gcc make iputils openssl
```
