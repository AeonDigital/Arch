# 401 - Conectando no wi-fi

Esta etapa apenas funcionará se você instalou os pacotes do item 320.2

``` shell
  # Inicia o "NetworkManager" para qualquer tipo de rede (cabo/wi-fi)
  NetworkManager start
  NetworkManager restart



  # Configura o sistema para sempre iniciar e habilitar o serviço
  sudo systemctl enable NetworkManager
  sudo systemctl start NetworkManager



  # Lista redes wifi próximas:
  nmcli device wifi list

  # Conecta a uma rede wifi:
  nmcli device wifi connect [SSID] password [senha]

  # Conecta a uma rede oculta:
  nmcli device wifi connect [SSID] password [senha] hidden yes

  # Conecta a um wifi na interface de rede wlan1:
  nmcli device wifi connect [SSID] password [senha] ifname wlan1 [nome_perfil]

  # Desconecta uma interface:
  nmcli device disconnect ifname eth0

  # Reconecta uma interface marcada como desconectada:
  nmcli connection up uuid [UUID]

  # Obtém uma lista de UUIDs:
  nmcli connection show

  # Vê uma lista de dispositivos de rede e seus estados:
  nmcli device
  nmcli wifi

  # Desliga o wifi:
  nmcli radio wifi off

  reboot
```
