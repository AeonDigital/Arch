# 210 - Criando as partições

Use o comando ``cfdisk`` e passe como parametro o disco que você deseja alterar.

**Exemplo:**
``` shell
  cfdisk /dev/sda
```
  A interface é relativamente simples.
  Selecione o espaço livre do disco e defina o tamanho de cada partição.
  Salve usando a opção "write" a cada passo para assegurar que a configuração foi efetivada.


**Atenção**
Altere o tipo de cada partição ainda dentro do programa ``cfdisk`` ANTES de salvar cada alteração.
Selecione cada partição definida e clique em ``write`` e então digite ``yes`` para confirmar.



## 210.1 - [Apenas em UEFI] Partição de Boot

Se sua placa mãe usa boot do tipo ``UEFI`` crie uma partição para o ``boot``.
Tamanho : 512M
Type: BIOS Boot



## 210.2 - Partição ``/`` (root)

Esta partição/diretório é onde ficará o sistema em si e as instalações compartilhadas entre
usuários. Usando uma dica do vídeo do **Diolinux** este não precisa ser muito grande.

Tamanho : 64G
Type: [Em UEFI] Linux filesystem
      [Em BIOS] Linux



## 210.3 - Partição ``/home``

Aqui ficam os arquivos de cada usuário e as instalações que são tipicas de cada qual, portanto 
precisa ser um diretório maior pois abrigará uma quantidade bem maior de informações.

Tamanho : 230G [exemplo baseado no atual disco que usei]
Type: [Em UEFI] Linux filesystem
      [Em BIOS] Linux



## 210.4 - Partição para o ``swap``

Tamanho : 4G [exemplo baseado no atual disco que usei]
Type: [Em UEFI] Linux swap
      [Em BIOS] Linux swap / Solaris



### 210.5 - Verificando as partições criadas

Use o comando descrito anteriormente:

``` shell
  fdisk -l /dev/sda
```
