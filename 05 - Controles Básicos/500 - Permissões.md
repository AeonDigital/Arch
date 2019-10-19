# 500 - Permissões

Se você é novo no ambiente Linux ou se ainda não entende completamenta o sistema de segurança do
mesmo, nesta etapa do tutorial pretendo trazer informações que possam lhe auxiliar a compreender
como tal sistema funciona e como você pode utilizá-lo para o que desejar.

Fontes:
> https://www.todoespacoonline.com/w/2015/06/usuarios-grupos-e-permissoes-no-linux-ubuntu/
> https://www.profissionaisti.com.br/2011/09/usuarios-e-grupos-no-linux/



## 500.1 - Permissões de uso e acesso

Primeiramente você precisa compreender que existem 3 formas básicas de controlar o acesso e o uso
de arquivos e diretórios, são as permissões **read**, **write** e **execute**, também referenciados
pelas letras **r**, **w** e **x** respectivamente.

Sabendo disso, e sabendo que cada permissão pode apenas estar ligada (1) ou desligada (0), podemos 
descrever a configuração referente a um objeto qualquer da seguinte forma:

```
  rwx
  111
```

No exemplo acima, os bits ligados (representados pelo número 1) indicam que o item recebe permissão
para ser lido, escrito e também executado. O valor binário ``111``, transcrito para decimal é 
equivalente ao numeral ``7 (sete)``, portanto, esta é a maior permissão que um usuário poderia ter
sobre um arquivo ou diretório.

Seguindo o mesmo raciocínio, observe o exemplo abaixo

```
  rwx
  101
```

Neste exemplo, o usuário teria capacidade apenas de leitura e execução mas não de escrita para o 
referido arquivo.
Novamente, convertendo o valor binário ``101`` para decimal, chegamos no número ``5 (cinco)``.
Sabendo que temos 3 possibilidades diferentes (rwx) e dois estados possíveis (0 e 1), podemos obter
até 8 combinações diferentes de permissões. São elas:

```
  ---
  000 = 0 [Nenhuma permissão]

  --x
  001 = 1 [Executar]

  -w-
  010 = 2 [Escrever]

  -wx
  011 = 3 [Escrever e executar]

  r--
  100 = 4 [Ler]

  r-x
  101 = 5 [Ler e executar]

  rw-
  110 = 6 [Ler e escrever]

  rwx
  111 = 7 [Ler, escrever e executar]
```

Observe que um traço "-" representa o bit desligado daquela permissão, ou seja, sem permissão. 
Além disso, diretórios recebem um "d" inicial. 
Exemplo:

```
  drwx  [representação de um diretório]
  -rwx  [representação de um arquivo]
```


**OBSERVAÇÃO**
Quando trata-se de arquivos, as 3 permisões significam exatamente o que seus nomes referem-se.
Já quando tratamos de diretórios, o entendimento das 3 permissões são:
- read    : Permite listar o que há dentro do diretório
- write   : Permite criar novos arquivos e diretórios dentro do diretório.
- execute : Permite que você possa entrar no diretório e acessar seus arquivos e outros diretórios.



## 500.2 - Proprietário, Grupo e Outros

As permissões de uso acima são aplicados individualmente a 3 casos de uso diferente para que o 
sistema saiba exatamente como cada item pode ser usado em cada situação. 

O primeiro caso de uso refere-se ao proprio dono do arquivo ou diretório e é chamado de **owner**.
O segundo caso de uso refere-se ao grupo que o objeto pertence e é chamado de **group**.
E o terceiro caso é o "outros" e refere-se a todos os demais grupos e usuários que não é o próprio
dono e também não pertencem ao mesmo grupo ao qual o objeto faz parte. Chama-se **others**.

Assim sendo, para cada diretório e arquivo existirão 3 conjuntos ``rwx``, cada qual referenciando
a como o sistema deverá reagir frente a cada um dos casos de uso descritos (owner, group e others).

Exemplo:

```
  drwxr-x--- [owner] [group]
```

No exemplo acima podemos identificar todas as permissões dadas a todos os casos de uso referidos:

* d       : Indica, neste caso, que trata-se de um diretório.
* rwx     : A primeira coleção de permissões refere-se a como o dono (owner) do objeto pode fazer
            uso do mesmo.
* r-x     : A segunda coleção de permissões refere-se a como os demais usuários que pertencem a 
            aquele grupo podem utilizar o referido objeto.
* ---     : A terceira coleção de permissões refere-se a como todos os demais usuários e grupos 
            podem interagir com este objeto. Neste caso, eles não tem qualquer acesso.
* [owner] : Nesta posição estará o nome do usuário que é o dono do objeto.
* [group] : Nesta posição estará o nome do grupo ao qual o objeto pertence.


Abaixo segue uma descrição de todos os dados que aparecem quando você usa um comando como o ``ls``
em conjunto com o parametro ``-l`` (lista os atributos de cada objeto no local indicado).

```
  -rw-rw-r-- 1 rianna users 5 Jun 5 4:30 filename.txt
  ^^  ^  ^   ^ ^      ^     ^ ^          ^
  ||  |  |   | |      |     | |          |
  ||  |  |   | |      |     | |          Nome do arquivo
  ||  |  |   | |      |     | Data e hora da última modificação
  ||  |  |   | |      |     Tamanho do arquivo em bytes
  ||  |  |   | |      Grupo ao qual o objeto pertence
  ||  |  |   | Proprietário do arquivo
  ||  |  |   Número de links 
  ||  |  Permissões para "outros"
  ||  Permissões para o grupo
  |Permissões para o proprietário do arquivo
  Se é um arquivo (-) ou diretório (d)
```
