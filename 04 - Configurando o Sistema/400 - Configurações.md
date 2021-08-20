# 400 - Configurações

As configurações descritas abaixo são em grande parte opcionais e podem ser feitas antes ou após 
o primeiro boot.


``` shell
  # configure o teclado pt-BR 
  # mais abaixo você verá como manter esta opção como padrão.
  loadkeys br-abnt2
```



&nbsp;

## 400.1 - Definindo seu fuso-horário

``` shell
  # Sincronize o clock do sistema com o da BIOS.
  hwclock --systohc --utc

  # Use o comando abaixo para listar os timezones
  timedatectl list-timezones

  # Selecione o seu [abaixo está 'America/Sao_Paulo']
  timedatectl set-timezone America/Sao_Paulo
  date
```



&nbsp;

## 400.2 - Habilitar o idioma pt-BR; Layout do teclado e Fonte

Primeiro, abra o arquivo ``/etc/locale.gen``.  
Procure pelo valor ``pt_BR.UTF-8 UTF-8`` e descomente-o, após, ative-o usando o comando indicado
no bloco abaixo

``` shell
  # use o comando abaixo para abrir o arquivo. Após alterá-lo, salve
  vim /etc/locale.gen

  # Se quiser, pode usar o comando abaixo para automatizar esta ação de descomentar
  # o locale pt-BR
  sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen


  # Execute o comando abaixo para fixar as alterações.
  locale-gen


  # Coloque a variável 'LANG' no arquivo 'locale.conf'
  echo LANG=pt_BR.UTF-8 >> /etc/locale.conf

  # As configurações abaixo preparam o seu teclado para ser reconhecido como sendo do padrão 
  # brasileiro ABNT2 e seta a fonte para uma que tem maior conformidade com a lingua portuguesa.
  echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
  echo FONT=lat1-16 >> /etc/vconsole.conf
```



&nbsp;

## 400.3 - Configurar o nome do computador e o arquivo ``hosts``

O valor definido no lugar de ``[NCR]`` (Nome do Computador Remoto) será usado para identificar a
máquina que está sendo configurada na rede.

``` shell
  echo [NCR] >> /etc/hostname

  vim /etc/hosts
  # Insira o seguinte conteúdo:
  # 127.0.0.1       localhost.localdomain   localhost
  # ::1             localhost.localdomain   localhost
  # 127.0.0.1       [NCR].localdomain       [NCR]
```



&nbsp;

## 400.4 - Trocar/Definir senha do usuário ``root``

``` shell
  passwd
  New password: 
  Retype new password
```



&nbsp;

## 400.5 - Criar novos usuários [opcional]

A primeira linha é realmente necessária caso queira criar um novo usuário.  
As demais adicionam o seu usuário em grupos que serão uteis caso você pretenda instalar uma 
interface gráfica.

``` shell
  # Modelo
  # useradd -m [user]

  useradd -m [user]
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


&nbsp;

### 400.5.1 - Adicionando seu usuário no ``sudoers`` 

**Edite o seguinte arquivo**
``` shell
  vim /etc/sudoers
```
  Vá até o final do arquivo e adicione o seguinte conteúdo:
  > [user] ALL=(ALL) ALL
