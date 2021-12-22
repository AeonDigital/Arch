# 200 - Primeiros passos

- Insira o **FlashDrive** na entrada USB do computador onde o **Arch** será instalado.
- Reinicie o computador e selecione o **FlashDrive** para dar o boot.
- Quando o instalador apresentar as opções, selecione instalação do *Boot Arch Linux (x86_64)*



&nbsp;

## 200.1 - Configuração do layout do teclado.

Uma das primeiras coisas a fazer é configurar o **Arch** para reconhecer seu teclado usando a
configuração do mesmo.
Teclados **ABNT2** (que é o padrão brasileiro) podem ser configurados usando o seguinte comando:

``` shell
  loadkeys br-abnt2
```



&nbsp;

## 200.2 - Configuração da internet

Para conseguir baixar os pacotes e efetivamente montar o seu S/O é importante ter internet.
Se você está com seu computador conectado com um cabo o instalador provavelmente já conseguiu um
``IP`` mas se você está em uma máquina que deseja conectar via ``wifi``, use os seguintes comandos:

- Confira se sua máquina já possui um ``IP`` com:
``` shell
  ip addr show
```

- Configure uma rede ``wifi`` com o seguinte aplicativo:
``` shell
  wifi-menu
```
  Na primeira tela você deve selecionar qual rede quer se conectar.
  Na segunda, você pode selecionar um nome para sua máquina na rede.
  Por fim, adicione a senha da rede, se ela for protegida.



&nbsp;

## 200.3 - Configurando o disco (``HDD`` ou ``SSD``) de instalação

Para a instalação adequada é preciso criar 3 ou 4 partições no seu disco (varia conforme o tipo de
modo que sua placa mae trabalha).
Neste tutorial é usado o nome ``BIOS`` para se referir ao modo ``LEGACY`` que é o antigo sistema
usado nas placas mães antes da adoção do sistema ``UEFI``.
Para placas mãe do tipo ``BIOS`` serão 3 partições e em modelos ``UEFI`` serão 4.

Você pode verificar quais discos estão no momento reconhecidos pelo instalador usando o comando:

``` shell
  fdisk -l
```


&nbsp;

### 200.3.1 - Conhecendo os discos conectados

O Linux enxerga todos os dispositivos conectados no computador como se fossem um sistema de
diretórios. No caso, o diretório ``dev`` (device) é onde estarão referenciados todos os
dispositivos habilitados para uso.

Os *diretórios* ``sd(a-z)`` (significa Sata Driver A;B;C ... Z) listam os discos conectados no
computador. Para uma instalação contendo apenas 1 disco no seu computador e o **FlashDrive**
plugado numa porta USB provavelmente o seu disco será visto como sendo ``/dev/sda`` e o
**FlashDrive** como sendo ``/dev/sdb``.

Cada dispositivo de disco terá um ou mais diretórios de nome igual, porém, numerados de 1 em
diante, referenciando-se nestes casos para cada partição existente no mesmo.
