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
  # use o comando abaixo para abrir o arquivo de configuração.
  vim /etc/locale.gen

  # Se quiser, pode usar o comando abaixo para automatizar esta ação de descomentar
  # o locale pt-BR
  sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen


  # Coloque a variável 'LANG' no arquivo 'locale.conf'
  echo LANG=pt_BR.UTF-8 >> /etc/locale.conf


  # Execute o comando abaixo para fixar as alterações.
  locale-gen "pt_BR.UTF-8"


  # As configurações abaixo preparam o seu teclado para ser reconhecido como sendo do padrão
  # brasileiro ABNT2 e seta a fonte para uma que tem maior conformidade com a lingua portuguesa.
  echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
  echo FONT=lat1-16 >> /etc/vconsole.conf
```



&nbsp;

## 400.3 - Ativando o ``numlock`` por padrão

Se você, como eu, gosta de usar o teclado numérico irá reparar rapidamente que ao iniciar o seu
terminal **Arch** verá que ele está desabilitado, inclusive, mudando de tty, cada novo estará também
com este recurso desabilitado.

Abaixo está o passo a passo do que é necessário para mantê-lo ativado sempre.
Note que há formas mais simples, mas seguindo estas orientações você aprenderá também como configurar
um serviço para começar a rodar ao iniciar seu computador.

Primeiramente, crie um script que efetivamente fará o trabalho de ativar o ``numlock`` em todos os
terminais ``tty`` disponíveis (o Arch inicia com 6).


``` /usr/local/bin/numlock
  # /usr/local/bin/numlock
  #!/bin/bash

  for tty in /dev/tty{1..6}; do
    /usr/bin/setleds -D +num < "$tty";
  done
```


Uma vez criado, dê permissões de execução para ele usando o comando abaixo:

``` shell
  chmod u+x /usr/local/bin/numlock
```


&nbsp;

O próximo passo será de criar um serviço que será iniciado juntamente com o computador e entrará
em execução antes, e independente de alguem efetuar o login no mesmo.
Note que este serviço evoca o script criado anteriormente.

``` /etc/systemd/system/numlock.service
# /etc/systemd/system/numlock.service
[Unit]
Description=numlock

[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

&nbsp;

Para finalizar agora você precisa registrar o serviço criado para que o computador saiba que precisa
iniciá-lo juntamente com seu próprio boot. Para isto execute os seguintes comandos:

``` shell
  # o nome do serviço é o mesmo valor indicado na chave 'Description' do serviço criado.
  systemctl enable numlock

  # se quiser iniciar o serviço imediatamente use:
  systemctl start numlock
```



&nbsp;

## 400.4 - Ativar a internet por padrão

Ativar o serviço de internet por padrão é simples, mas se precisar configurar o wi-fi vá para o
item 401.

``` shell
  systemctl enable NetworkManager
```



&nbsp;

## 400.5 - Configurar o nome do computador e o arquivo ``hosts``

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

## 400.6 - Trocar/Definir senha do usuário ``root``

``` shell
  passwd
  New password:
  Retype new password
```



&nbsp;

## 400.7 - Criar novos usuários [opcional]

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

### 400.7.1 - Adicionando seu usuário no ``sudoers``

Note, é mais indicado adicionar o seu usuário a um grupo que seja um ``sudoer`` mas há casos em
que você quer ou precisa ter um usuário neste grupo sem ser o root... neste caso siga as
instruções.

**Edite o seguinte arquivo**
``` shell
  vim /etc/sudoers
```
  Vá até o final do arquivo e adicione o seguinte conteúdo:
  > [user] ALL=(ALL) ALL
