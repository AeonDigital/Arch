# 210 - Criando as partições

O instalador do ``Arch`` traz dois programas que lhe permitem lidar com as partições dos seus HDs.
Um é o ``fdisk`` cuja interface é mais básica e 'procedural';
Já o outro é o ``cfdisk`` cuja interface é mais amigável e é a usada neste tutorial para facilitar
o entendimento.
Abaixo há a explicação de ambos os casos de uso; A vantagem do primeiro é que é possível torna-lo
``scriptável`` ;)



&nbsp;

## 210.1 - Usando o ``cfdisk``

Use o comando ``cfdisk`` e passe como parametro o disco que você deseja alterar.

**Exemplo:**
``` shell
  cfdisk /dev/sda

  # Ou, use o comando abaixo para usar o fdisk
  # fdisk /dev/sda
```
  A interface é relativamente simples.  
  Selecione o espaço livre do disco e defina o tamanho de cada partição.  
  Salve cada alteração feita usando a opção "write" para assegurar que a configuração foi 
  efetivada.


**Atenção**
Altere o tipo de cada partição ainda dentro do programa ``cfdisk`` ANTES de salvar cada 
alteração.  
Selecione cada partição definida e clique em ``write`` e então digite ``yes`` para confirmar.


&nbsp;

### 210.1.1 - [Apenas em UEFI] Partição EFI System

Se sua placa mãe usa boot do tipo ``UEFI``.

Tamanho   : 512M (sem interface; baseado em minha experiência própria)  
Indicado  : 1G (baseado no meu uso padrão)  
Type      : EFI System


&nbsp;

### 210.1.2 - [Apenas em Bios] Partição BIOS Boot

Se sua placa mãe usa boot do tipo ``BIOS``.

Tamanho   : 512M (sem interface; baseado em minha experiência própria)  
Indicado  : 1G (baseado no meu uso padrão)  
Type      : BIOS Boot


&nbsp;

### 210.1.3 - Partição para o ``swap``

Mínimo    : 512M (sem interface; baseado em minha experiência própria)  
Indicado  : 4G (baseado no meu uso padrão)  
Type      : Linux swap


&nbsp;

### 210.1.4 - Partição root; ``/``

Esta partição/diretório é onde ficará o sistema em si e as instalações compartilhadas entre 
usuários.  
Usando uma dica do vídeo do **Diolinux** este não precisa ser muito grande.

Mínimo    : 2G (sem interface; baseado em minha experiência própria)  
Indicado  : 64G (baseado no meu uso padrão)  
Type      : Linux filesystem  


&nbsp;

### 210.1.5 - Partição home; ``/home`` (opcional)

Aqui ficam os arquivos de cada usuário e as instalações que são tipicas de cada qual, portanto 
precisa ser uma partição maior pois abrigará uma quantidade bem maior de informações.
Você pode optar por não criar esta partição e deixar todo o restante do espaço alocado na
partição de root (esta opção parece mais acertada para máquinas virtuais).

Mínimo    : 2G (sem interface; baseado em minha experiência própria)  
Indicado  : 230G (baseado no meu uso padrão)  
Type      : Linux filesystem  



&nbsp;

## 210.2 - Usando o ``fdisk``

Primeiramente você terá que escolher se usará um tipo MBR ou GPT.  
Depois, siga a orientação correspondente ao tipo de sistema de boot que a placa mãe usada.  

As orientações abaixo geram o mesmo efeito das que foram explicadas no tópico anterior.

``` shell
  fdisk /dev/sda

  # UEFI | GPT
  g     # converte o disco em GPT; exclui todas as partições existentes
  # BIOS | MBR
  o     # converte o disco em MBR; exclui todas as partições existentes



  n     # nova partição (1)
        # \n aceita '1' como número da nova partição
        # \n aceita valor proposto para o primeiro setor
  +512M # usa 512M como tamanho da nova partição.
  t     # prepara para redefinir o tipo da partição
  # UEFI | GPT
  1     # define a partição como sendo 'EFI System'
  # BIOS | MBR
  4     # define a partição como sendo 'BIOS boot'



  n     # nova partição (2)
        # \n aceita '2' como número da nova partição
        # \n aceita valor proposto para o primeiro setor
  +512M # usa 512M como tamanho da nova partição.
  t     # prepara para redefinir o tipo da partição
        # \n para confirmar seleção da partição '2' como alvo da alteração do tipo de partição
  19    # define a partição como sendo 'Linux Swap'
  n     # nova partição (3)
        # \n aceita '3' como número da nova partição
        # \n aceita valor proposto para o primeiro setor
        # \n para usar todo o restante do espaço livre.
```
  O comando ``m`` lista todas as opções de alteração que você pode realizar usando este comando.
  Se fizer alguma alteração que quiser efetivar, lembre de usar o comando ``w``.
  Se não tiver certeza do que está fazendo e quiser sair sem salvar, use o comando ``q``.


&nbsp;

### 210.2.1 - Automatizando os comandos com ``fdisk``

Abaixo, como executar os mesmos comandos do tópico anterior usando uma única linha no shell.
Repare que a cada 'enter' é adicionado um '\n'

``` shell
  # UEFI | GPT
  echo -e "g\nn\n\n\n+512M\nt\n1\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda

  # BIOS | MBR
  echo -e "o\nn\n\n\n+512M\nt\n4\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
```



&nbsp;

### 210.3 - Verificando as partições criadas

Use o comando abaixo:

``` shell
  fdisk -l /dev/sda
```
