# 530 - Alterando permissões e atributos de objetos

Sabidamente, é possível alterar as permissões definidas para objetos do sistema podendo inclusive
alterar quem é seu dono ou o grupo ao qual ele pertence. Para isto, o usuário que efetua tal 
alteração precisa, ele próprio, ter permissão para efetuar tais alterações. 
Apenas o usuário **root** tem permissão para usar os comandos abaixo.



## 530.1 - CHMOD

O comando ``chmod`` (change mod) permite que você edite as permissões atualmente definidas para 
um objeto.
Use a seguinte sintaxe:

``` shell
  chmod [permissoes] [objeto] [-R]
```

* permissoes    : Aqui você deve indicar quais serão as novas permissões que o objeto irá herdar.
                  Use o formato de 3 octetos, sendo valores de 000 à 777 conforme descrito na 
                  etapa sobre Permissões.
* objeto        : Caminho completo até o objeto apartir do local onde você está no momento.
* -R            : Este item é opcional e deve ser usado quando trata-se de diretórios.
                  Sua presença indica que as permissões aqui definidas serão repassadas para todos
                  os arquivos, diretórios e subdiretórios dentro do objeto alvo.



## 530.2 - CHOWN

O comando ``chown`` (change owner) permite que você redefina o dono de um arquivo ou diretório.

``` shell
  chown [proprietario] [objeto] [-R]
```

* proprietario  : Use o nome do novo proprietário do objeto alvo.
* objeto        : Caminho completo até o objeto que é o alvo desta ação.
* -R            : Este item é opcional e deve ser usado quando trata-se de diretórios.
                  Sua presença indica que tanto o diretório alvo quanto tudo o que está dentro dele
                  terá seu dono alterado conforme está sendo definido.



## 530.2 - CHGRP

O comando ``chgrp`` (change group) permite que você redefina o grupo de um arquivo ou diretório.

``` shell
  chgrp [grupo] [objeto] [-R]
```

* grupo         : Nome do grupo ao qual o objeto passará a pertencer.
* objeto        : Caminho completo até o objeto que é o alvo desta ação.
* -R            : Este item é opcional e deve ser usado quando trata-se de diretórios.
                  Sua presença indica que tanto o diretório alvo quanto tudo o que está dentro dele
                  terá seu grupo alterado conforme está sendo definido.
