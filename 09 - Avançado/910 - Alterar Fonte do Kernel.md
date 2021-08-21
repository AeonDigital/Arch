# 910 - Alterar a fonte do kernel

Isto parece meio excêntrico - e de fato é - mas como eu disse noutra etapa deste tutorial, eu gosto
do meu computador como EU gosto. ;)

> Você precisará saber onde na sua distribuição está o arquivo ``font_8x16.c`` ou o equivalente
> pois de outra forma este tutorial não lhe será útil. Até o momento, para o Arch Linux eu não
> encontrei onde o arquivo equivalente se encontra. Então, para você não perder tempo também
> primeiro descubra sobre isto e após, siga em frente.

As informações abaixo foram extraidas diretamente da URL:
> https://www.artembutusov.com/modify-linux-kernel-font/


## 910.1 - Você precisará de fontes de terminal

Em primeiro lugar você precisa conseguir fontes com a extenção ``psf`` para que possamos 
convertê-las num formato que possa ser interpretado pelo kernel.
Por motivo inicial de praticidade - e por falta de tempo de procurar algo mais específico - optei
pelo conjunto ``terminus-font``

``` shell
  pacman -S terminus-font
```

As fontes que vem neste pacote possuiem alguns códigos no seu nome que podem ser identificados
a partir do esquema abaixo retirado diretamente da documentação oficial

Apenas como exemplo, tome a fonte "ter-i32b.psf.gz":

``` https://raw.githubusercontent.com/legionus/kbd/master/data/consolefonts/README.Lat2-Terminus16
  Legend

  names	mappings		covered codepage(s)

  ter-1*	iso01, iso15, cp1252	ISO8859-1, ISO8859-15, Windows-1252
  ter-2*	iso02, cp1250		ISO8859-2, Windows-1250
  ter-9*	iso09, cp1254		ISO8859-9, Windows-1254
  ter-c*	cp1251, iso05		Windows-1251, ISO8859-5
  ter-d*	iso13, cp1257		ISO8859-13, Windows-1257
  ter-g*	iso16			ISO8859-16
  ter-i*	cp437			IBM-437
  ter-k*	koi8r			KOI8-R
  ter-m*	mik			Bulgarian-MIK
  ter-p*	pt154			Paratype-PT154
  ter-u*	koi8u			KOI8-U
  ter-v*	all listed above,	all listed above, Paratype-PT254,
    pt254 etc. (if you	Macintosh-Ukrainian, KOI8-U/E/F and
    have such mappings)	IBM-852/855/866, 8 foreground colors

  names	style

  ter-*n	normal
  ter-*b	bold
  ter-*f	framebuffer-bold
```

Para ter uma ideia de como se parece algumas das fontes do pacote você pode verificar as imagens
adicionada no diretório **fontes-imagens**. Não há imagens para todos os casos mas já é uma orientação 
melhor que nada :P .
A origem destas imagens são o site:
  > https://www.zap.org.au/software/fonts/console-fonts-distributed/psftx-fedora-28/index.html





## 910.2 - Instale o pacote psftools

Até a data da criação deste documento, este pacote não está disponível no repositório oficial do 
**Arch** mas pode ser encontrado no **AUR** (Arch User Repository).

  > https://aur.archlinux.org/packages/psftools/

Se você não tem o git instalado pode fazer o download do pacote use o ``wget``. 
Após, descompacte, entre no diretório criado, dê permissão de execução ao ``script configure``,
rode o ``configure``, compile e instale.

``` shell
  wget http://www.seasip.info/Unix/PSF/psftools-1.0.13.tar.gz
  tar -vzxf psftools-1.0.13.tar.gz
  cd psftools-1.0.13
  chmod 711 configure
  ./configure
  make
  make install
```



## 910.3 - Convertendo a fonte selecionada

No meu caso selecionei a seguinte fonte:

  > /usr/share/kbd/consolefonts/lat1-16.psfu.gz

Crie um diretório em um local público para receber a nova fonte.
Copie a fonte selecionada para este novo diretório.
Descompacte ela se ela estiver compactada.
Execute o ``psf2inc`` para converte-lo em um formato **.inc**

``` shell
  mkdir /etc/fonts/kernel
  cd /etc/fonts/kernel
  cp /usr/share/kbd/consolefonts/lat1-16.psfu.gz .
  gunzip lat1-16.psfu.gz
  psf2inc lat1-16.psfu > lat1-16.inc
```



### 910.4 - Efetue a "raspagem" dos bits do arquivo .inc

Sim... nesta parte o negócio complica um pouco mas seguindo as instruções abaixo você verá que é 
até simples... para quem chegou aqui, não custa muito.

Dentro do arquivo **.inc** gerado no passo anterior você pode ver o interior da sua fonte.
Por sorte, na coversão você ganha uns comentários que indicam onde está o que, assim você pode 
identificar cada linha de dados referente a cada caracter. Eles estão separados por comentários 
começando em /* 0 */ e terminando em /* 255 */.

O que precisamos fazer agora é criar um arquivo **.hex**, cópia do **.inc** e editá-lo para manter 
neste novo arquivo UNICAMENTE os dados referentes a cada caracter e absolutamente nada além.

Veja abaixo uma representação de como é o arquivo da fonte que eu selecionei aberto num editor:

``` shell
  cp lat1-16.inc lat1-16.hex
  vim lat1-16.hex
```

``` lat1-16.hex
  0x72, 0xb5, 0x4a, 0x86,   /* Magic */
  0x00, 0x00, 0x00, 0x00,   /* Version */
  0x20, 0x00, 0x00, 0x00,   /* Header size */
  0x01, 0x00, 0x00, 0x00,   /* Flags */
  0x00, 0x01, 0x00, 0x00,   /* No. of chars */
  0x10, 0x00, 0x00, 0x00,   /* Char length */
  0x10, 0x00, 0x00, 0x00,   /* Char width */
  0x08, 0x00, 0x00, 0x00,   /* Char height */
  0x00, 0x00, 0x7e, 0xc3, 0x99, 0x99, 0xf3, 0xe7,
  0xe7, 0xff, 0xe7, 0xe7, 0x7e, 0x00, 0x00, 0x00,   /* 0 */
  0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0xdc, 0x00,
  0x76, 0xdc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,   /* 1 */
  0x00, 0x00, 0x6e, 0xf8, 0xd8, 0xd8, 0xdc, 0xd8,
  0xd8, 0xd8, 0xf8, 0x6e, 0x00, 0x00, 0x00, 0x00,   /* 2 */

  ...

  0xc6, 0xc6, 0xc6, 0x7e, 0x06, 0x0c, 0xf8, 0x00,   /* 253 */
  0x00, 0x00, 0xf0, 0x60, 0x60, 0x7c, 0x66, 0x66,
  0x66, 0x66, 0x7c, 0x60, 0x60, 0xf0, 0x00, 0x00,   /* 254 */
  0x00, 0x00, 0x00, 0x6c, 0x00, 0xc6, 0xc6, 0xc6,
  0xc6, 0xc6, 0xc6, 0x7e, 0x06, 0x0c, 0xf8, 0x00,   /* 255 */
  0xef, 0xbf, 0xbd, 0xff,
  0xe2, 0x89, 0x88, 0xff,
  0xc5, 0x92, 0xff,
  0xc5, 0x93, 0xff,
  0xe2, 0x97, 0x86, 0xff,
  0xe2, 0x90, 0x89, 0xff,

  ...
```


Agora veja abaixo tudo o que restou após a **raspagem**:

``` lat1-16.hex
  0x00, 0x00, 0x7e, 0xc3, 0x99, 0x99, 0xf3, 0xe7,
  0xe7, 0xff, 0xe7, 0xe7, 0x7e, 0x00, 0x00, 0x00,   /* 0 */
  0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0xdc, 0x00,
  0x76, 0xdc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,   /* 1 */
  0x00, 0x00, 0x6e, 0xf8, 0xd8, 0xd8, 0xdc, 0xd8,
  0xd8, 0xd8, 0xf8, 0x6e, 0x00, 0x00, 0x00, 0x00,   /* 2 */

  ...

  0xc6, 0xc6, 0xc6, 0x7e, 0x06, 0x0c, 0xf8, 0x00,   /* 253 */
  0x00, 0x00, 0xf0, 0x60, 0x60, 0x7c, 0x66, 0x66,
  0x66, 0x66, 0x7c, 0x60, 0x60, 0xf0, 0x00, 0x00,   /* 254 */
  0x00, 0x00, 0x00, 0x6c, 0x00, 0xc6, 0xc6, 0xc6,
  0xc6, 0xc6, 0xc6, 0x7e, 0x06, 0x0c, 0xf8, 0x00,   /* 255 */
```


Faça a mesma **limpeza** no arquivo **.hex** da sua fonte selecionada, salve e estará pronto para 
ir para o próximo passo.


**Forma Alternativa**
  Bem... obviamente existe uma forma programática de resolver o problema apresentado nesta seção mas
  para isto você precisa conhecer algumas informações sobre sua fonte:

  - ``NCHARS``  : Número total de caracteres de sua fonte
  - ``W``       : Largura da fonte  em pontos/pixels
  - ``H``       : Altura da fonte   em pontos/pixels
  - ``DPB``     : "Dots Per Byte"   padrão = 8 [pode variar conforme a fonte selecionada]
  - ``BPL``     : "Bytes Per Line"  padrão = 8 [pode variar conforme a fonte selecionada]

  Ao menos entre as fontes da coleção ``terminus`` é fácil identificar estas informações e você
  pode usar as referencias visuais alocadas na pasta ``Fontes`` desta seção do tutorial. Em cada 
  imagem, além dos próprios caracteres você identifica todos os itens acima.

  Sabendo estas informações use a seguinte fórmula:

  > endChar = 1 + (((NCHARS * W * H) / DPB) / BPL)
  > Informações da fonte selecionada: 
  >   lat1-16
  >   - NCHARS  = 256
  >   - W       = 8
  >   - H       = 16
  >   - DPB     = 8
  >   - BPL     = 8
  > endChar = 1 + (((256 * 8 * 16) / 8) / 8)
  > endChar = 513

  Agora use o seguinte comando
  
  ``` shell
    cat lat1-16.inc | sed '0,/Char height/d' | sed '513,$d' > lat1-16.hex
  ```

  Se os valores estiverem corretos você obterá um arquivo **.hex** devidamente *limpo* e pronto
  para ir para o próximo passo.



### 910.5 - Editando o arquivo de fonte final [não testado]

Quase no fim. 
Agora você precisa criar um novo arquivo chamado **font_8x16.c** e adicionar nele o template que 
será mostrado abaixo:

``` template
  #include <linux/font.h>
  #include <linux/module.h>
  #define FONTDATAMAX ((NCHARS * W * H) / DPB)
  static const unsigned char fontdata_8x16[FONTDATAMAX] = {
    !!ADICIONE O CONTEUDO .hex DE SUA FONTE AQUI!!
  };
  const struct font_desc font_vga_8x16 = {
    .idx    = VGA8x16_IDX,
    .name   = "VGA8x16",
    .width  = W,
    .height = H,
    .data   = fontdata_8x16,
    .pref   = 0,
  };
  EXPORT_SYMBOL(font_vga_8x16);
```

Substitua no template os valores já conhecidos como ``W`` e ``H``; Faça o cálculo indicado para 
descobrir o valor que a constante ``FONTDATAMAX`` deve ter; Por fim, aloque todo o conteúdo do 
arquivo **.hex** (devidamente "raspado") criado no passo anterior e salve.

Para facilitar, crie uma cópia do arquivo **.hex** com o nome **font_8x16.c** e então copie as 
primeiras 4 linhas do template acima para o início do novo arquivo e após, tudo o que está a partir
da linha 6 do template. 


### 910.6 - Substitua a fonte do kernel e recompile-o [não testado]

Se você chegou até aqui provavelmente tem coragem de ir adiante.
Observe os comandos a seguir que você entenderá bem o que está sendo feito.
Ao final do processo, reinicie.

``` shell
  mv /usr/src/linux/lib/fonts/font_8x16.c /usr/src/linux/lib/fonts/font_8x16.c.org
  cp font_8x16.c /usr/src/linux/lib/fonts/
  cd ~
  rm ~/new-font -rf
  rm /usr/src/linux/lib/fonts/*.o
  genkernel kernel --no-clean
```

Pronto
Pode reiniciar e você verá que o kernel usará a fonte definida ao efetuar o boot.
