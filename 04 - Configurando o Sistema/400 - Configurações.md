# 400 - Configurações

As configurações descritas abaixo são em grande parte opcionais e podem ser feitas antes ou após 
o primeiro boot.



## 400.1 - Alterando o seu fuso-horário

``` shell
  mkdir /etc/localtime
  ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
```



## 400.2 - Sincronize o clock do sistema com o da BIOS.

``` shell
  hwclock --systohc --utc
  date 
```



## 400.3 - Habilitar o idioma pt-BR

**Edite o seguinte arquivo**
``` shell
  vim /etc/locale.gen
```

Procure pelo valor ``pt_BR.UTF-8 UTF-8`` e descomente-o, após, ative-o usando:

``` shell
  locale-gen
```



## 400.4 - Colocar a variável de linguagem em ``locale.conf``

``` shell
  echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
```



## 400.5 - Configurar o teclado e fonte

As configurações abaixo preparam o seu teclado para ser reconhecido como sendo do padrão brasileiro
ABNT2 e seta a fonte para uma que tem maior conformidade com a lingua portuguesa.

``` shell
  echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
  echo FONT=lat1-16 >> /etc/vconsole.conf
```



## 400.6 - Configurar o nome do computador na rede

``` shell
  echo [NCR] >> /etc/hostname
```



## 400.7 - Configurar o ``hosts``

**Edite o seguinte arquivo**
``` shell
  vim /etc/hosts
```
  Insira o seguinte conteúdo:
  > 127.0.0.1       localhost.localdomain   localhost
  > ::1             localhost.localdomain   localhost
  > 127.0.0.1       [NCR].localdomain       [NCR]



## 400.8 - Trocar/Definir senha do usuário ``root``

``` shell
  passwd
  New password: 
  Retype new password
```



## 400.9 - Criar novos usuários

A primeira linha é realmente necessária. 
As demais adicionam o seu usuário em grupos que serão uteis caso você pretenda instalar uma interface 
gráfica.

``` shell
  useradd -m -g users -G wheel [user]
  passwd [user]
  New password: 
  Retype new password
  gpasswd -a [user] sys
  gpasswd -a [user] lp
  gpasswd -a [user] network
  gpasswd -a [user] video
  gpasswd -a [user] optical
  gpasswd -a [user] storage
  gpasswd -a [user] scanner
  gpasswd -a [user] power
```



### 400.9.1 - Adicionando seu usuário no ``sudors`` 

**Edite o seguinte arquivo**
``` shell
  vim /etc/sudoers
```
  Vá até o final do arquivo e adicione o seguinte conteúdo:
  > [user] ALL=(ALL) ALL
