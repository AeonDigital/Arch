# 900 - Compilar e instalar pacotes

Uma atividade eventual para um usuário de Linux é, ao receber o código fonte de uma aplicação, 
realizar a extração dos dados, compilar e então instalar. Abaixo segue uma breve descrição do 
que exatamente significam estas ações.

As informações abaixo foram extraidas diretamente da URL:
> https://klebermota.eti.br/2016/11/25/a-magica-por-tras-dos-comandos-configure-make-make-install/



## 900.1 - Configuração do software

O ``script configure`` é responsável por deixar tudo pronto para compilar o software para nosso 
sistema. Ele garante que todas as dependências necessárias para completar o processo de compilação 
e instalação estão disponíveis, e encontra tudo o que for necessário para usar essas dependências.

Programas Unix são geralmente escritos em ``C``, de forma que normalmente precisamos de um 
compilador ``C`` para compilá-los. Nesses casos, o ``script configure`` irá verificar se seu 
sistema possui um compilador ``C``, descobrirá como ele é chamado e onde ele está instalado.



## 900.2 - Compilação do software

Uma vez que o ``script configure`` tiver feito o seu trabalho, podemos invocar ``make`` para 
compilar o software. Esse comando irá executar uma série de tarefas definidas em um ``Makefile`` 
para compilar o programa a partir de seu código fonte.

O ``tarball`` que você baixou normalmente não inclui um ``Makefile`` finalizado. Ao invés disso, 
ele traz um modelo chamado ``Makefile.in`` e o ``script configure`` produz um ``Makefile`` 
personalizado para o seu sistema.



## 900.3 - Instalação do software

Agora que o software foi compilador e está pronto para ser executado, os arquivos podem ser 
copiados para seus destinos finais. O comando ``make install`` irá copiar o programa compilado, 
e suas bibliotecas e documentação para os diretórios corretos.

Isso normalmente significa que os binários do programa serão copiados para um diretório de seu 
``PATH``, as páginas de manual do programa serão copiadas para um diretório de seu ``MANPATH`` e 
qualquer outro arquivo que o programa dependa será armazenado se forma segura no seu local 
apropriado.

Como o passo de instalação também é definido no ``Makefile``, o local onde o software é instalado 
pode ser alterado baseado nas opções passadas para o ``script configure``, ou por informações que 
o ``script configure`` irá descobrir sobre o seu sistema.

Dependendo de onde o software precisar ser instalado, você pode precisar de um maior nível de 
acesso para essa etapa de forma que você possa copiar os arquivos para os diretórios do sistema. 
Usar ``sudo`` frequentemente irá resolver isso.



## 900.4 - De onde esses scripts vem

Tudo isso funciona porque um ``script configure`` examina o seu sistema, e usa a informação que 
encontra para converter o modelo ``Makefile.in`` em um ``Makefile``, mas de onde o 
``script configure`` e o modelo ``Makefile.in`` vem?

Se você alguma vez abriu um ``script configure``, ou o ``Makefile.in`` relacionado, você teria visto 
que eles possuem milhares de linhas de código de um ``shell script`` bastante denso. Algumas vezes 
esses scripts de suporte são maiores do que o código fonte do programa que eles instalam.

Mesmo iniciando de um ``script configure`` existente, seria bastante desafiador construir um 
manualmente. Não se preocupe, porém: esses scripts não são criados à mão.

Programas que são compilados dessa forma são normalmente empacotados através de um conjunto de 
programas chamado coletivamente de ``autotools``. Esse conjunto inclui o ``autoconf``, ``automake`` 
e muitos outros programas, sendo que todos trabalham em conjunto para tornar a vida de um 
mantenedor muito mais fácil. O usuário final não enxerga essas ferramentas, mas elas tiram a dor 
de ter configurar um processo de instalação que possa ser executado de forma consistente em muitos 
sabores diferentes de ``Unix``.



## 900.5 - Hello world

Vamos usar como exemplo um programa ``C`` simples, e ver o que seria necessário para empacotá-lo 
usando as ``autotools``.

Abaixo segue o código fonte do programa, em um arquivo chamado ``main.c``:

``` main.c
  #include <stdio.h>
  int
  main(int argc, char* argv[])
  {
    printf("Hello world\n");
    return 0;
  }
```



### 900.5.1 - Criando o script de configuração

Ao invés de digitar o ``script configure`` à mão, iremos criar um arquivo chamado ``configure.ac`` 
usando ``m4sh`` – uma combinação de macros m4 e shell scripts POSIX – para descrever o que  o 
``script configure`` precisa fazer.

O primeiro ``macro m4`` que precisamos chamar é ``AC_INIT``, que irá inicializar o ``autoconf`` e 
configurar algumas informações básicas sobre o programa que iremos empacotar. O programa será 
chamado ``helloworld``, a versão será ``0.1``, e o mantenedor será ``george@thoughtbot.com``:

``` configure.ac
  AC_INIT([helloworld], [0.1], [george@thoughtbot.com])
```

Iremos usar o ``automake`` nesse projeto, dessa forma precisamos inicializar a macro ``AM_INIT_AUTOMAKE``:

``` configure.ac
  AM_INIT_AUTOMAKE
```

Em seguida, precisamos informar ao ``autoconf`` sobre as dependências que nosso ``script configure`` 
precisará checar. No nosso caso, o ``script configure`` precisará apenas verificar se existe um 
compilador ``C`` instalado. Podemos configurar isso usando a macro ``AC_PROG_CC``:

``` configure.ac
  AC_PROG_CC
```

Se houverem outras dependências, podemos usar outras ``macros m4`` para encontrá-las; por exemplo, 
a macro ``AC_PATH_PROG`` procurar por um certo programa no ``PATH`` do usuário.

Agora que listamos nossas dependências, podemos usá-las. Nós vimos anteriormente que um 
``script configure`` típico usará a informação que possui sobre o sistema do usuário para criar um 
``Makefile`` a partir de um modelo ``Makefile.in``.

A linha seguinte usa a macro ``AC_CONFIG_FILES`` para informar ao ``autoconf`` que o ``script configure`` 
deve fazer justamente isso: deve localizar um arquivo com o nome ``Makefile.in``, substituir textos 
como ``@PACKAGE_VERSION@`` por valores como ``0.1``, e escrever os resultados em um arquivo ``Makefile``.

``` configure.ac
  AC_CONFIG_FILES([Makefile])
```

Finalmente, após informar ao ``autoconf`` tudo o que nosso ``script configure`` precisa fazer, podemos 
chamar a macro the ``AC_OUTPUT`` para definir a saída do script:

``` configure.ac
  AC_OUTPUT
```

Abaixo segue todo o conteúdo do arquivo. nada mau, comparado com as 4,737 linhas que serão produzidas 
no ``script configure`` final!

``` configure.ac
  AC_INIT([helloworld], [0.1], [george@thoughtbot.com])
  AM_INIT_AUTOMAKE
  AC_PROG_CC
  AC_CONFIG_FILES([Makefile])
  AC_OUTPUT
```

Estamos quase prontos para empacotar e distribuir nosso programa, mas ainda temos mais uma coisa 
para fazer. Nosso ``script configure`` irá procurar por um arquivo ``Makefile.in`` que poderá 
substituir todas essas variáveis específicas do sistema, mas até agora, ainda não criamos esse 
arquivo.



### 900.5.2 - Criando o Makefile

Assim como no caso do ``script configure``, o modelo ``Makefile.in`` é muito longo e complexo. 
Assim, ao invés de escreve-lo à mão, iremos criar um arquivo ``Makefile.am`` mais curto, que o 
utilitário ``automake`` irá usar para gerar o arquivo ``Makefile.in`` para nós.

Em primeiro lugar, precisamos configurar algumas opções para informar ao ``automake`` sobre o 
layout do projeto. Como não estamos seguindo o layout padrão de um projeto ``GNU``, devemos 
avisar ao ``automake`` que estamos lidando com um projeto foreign:

``` Makefile.am
  AUTOMAKE_OPTIONS = foreign
```

Em seguida, informamos ao ``automake`` que queremos que o ``Makefile`` crie um programa chamado 
``helloworld``:

``` Makefile.am
  bin_PROGRAMS = helloworld
```

Há um bocado de informação empacotada nessa linha, graças ao esquema de nomes uniforme do 
``automake``.

O sufixo ``PROGRAMS`` é chamado de ``primary``. Ele diz ao ``automake`` que propriedades o arquivo 
``helloworld`` possui. Por exemplo, ``PROGRAMS`` precisa ser compilado, enquanto arquivos marcados 
como ``SCRIPTS`` e ``DATA`` não precisam.

O prefixo ``bin`` informa ao ``automake`` que o arquivo listado aqui deve ser instalado no 
diretório definido pela variável ``bindir``. Existem vários diretórios definidos para nós pelo 
``autotools`` incluindo ``bindir``, ``libdir``, e ``pkglibdir—mas`` também podemos definir nossos 
próprios diretórios.

Se quisessemos instalar alguns scripts ``Ruby`` como parte de nosso programa, poderíamos definir a 
variável ``rubydir`` e informar ao ``automake`` para instalar nosso arquivos de script ``Ruby`` nele:

``` Makefile.am
  rubydir = $(datadir)/ruby
  ruby_DATA = my_script.rb my_other_script.rb
```

Prefixos adicionais podem ser adicionados antes do diretório de instalação para um ajuste mais 
amplo do comportamento do ``automake``.

Como definimos um ``PROGRAM``, precisamos informar ao ``automake`` onde encontrar os arquivos de 
código fonte a serem compilados. Nesse caso, o prefixo é o nome do programa que esses arquivos 
irão criar, ao invés do local onde eles serão instalados:

``` Makefile.am
  helloworld_SOURCES = main.c
```

Abaixo segue o arquivo ``Makefile.am`` inteiro para nosso programa ``helloworld``. Como no caso do 
``configure.ac`` e do ``script configure``, é muito mais curto do que o arquivo ``Makefile.in`` 
que ele gera:

``` Makefile.am
  AUTOMAKE_OPTIONS = foreign
  bin_PROGRAMS = helloworld
  helloworld_SOURCES = main.c
```



### 900.5.3 - Pondo tudo para trabalhar

Agora que criamos nossos arquivos de configuração, podemos executar as ferramentas do ``autotools`` 
e gerar os arquivos de ``script configure`` e o modelo ``Makefile.in`` finais.

Primeiro, precisamos gerar um ambiente ``m4`` para o uso do autotools:

``` shell
  aclocal
```

Agora, podemos executar o ``autotools`` para converter nosso arquivo ``configure.ac`` em um 
``script configure``, e ``automake`` para converter o arquivo ``Makefile.am`` em um` ``Makefile.in``:

``` shell
  autoconf
  automake --add-missing
```


### 900.5.4 - Distribuir o programa

O usuário final não precisa visualizar nossos arquivos de configuração do ``autotools``, assim 
podemos distribuir apenas o ``script configure`` e o arquivo ``Makefile.in`` sem nenhum dos arquivos 
usados para gerá-los.

Felizmente, o ``autotools`` irá nos ajudar com a distribuição também. O ``Makefile`` contém todo 
tipo de alvos interessentes, incluindo um para criar um ``tarball`` de projeto contendo todos os 
arquivos que você precisa distribuir:

``` shell
  ./configure
  make dist
```

Você pode até testar se o ``tarball`` a ser distribuido pode ser instalado sob várias condições:

``` shell
  make distcheck
```


### 900.5.5 - Visão geral

Agora sabemos como a mágica funciona!

No sistema do mantenedor:

``` shell
  # Set up an m4 environment
  aclocal 
  # Generate configure from configure.ac
  autoconf 
  # Generate Makefile.in from Makefile.am
  automake --add-missing 
  # Generate Makefile from Makefile.in
  ./configure 
  # Use Makefile to build and test a tarball to distribute
  make distcheck 
```

No sistema do usuário final:

``` shell
  # Generate Makefile from Makefile.in
  ./configure 
  # Use Makefile to build the program
  make 
  # Use Makefile to install the program
  make install 
```
