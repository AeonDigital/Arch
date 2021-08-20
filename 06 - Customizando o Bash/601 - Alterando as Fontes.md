# 601 - Alterando as fontes

Uma das primeiras coisas que você pode alterar é a fonte de apresentação usada no seu terminal.  
É aconselhado conferir se a fonte que vem configurada por padrão é adequada a sua linguagem.  
Neste momento [2019-10-07] a fonte que o Arch configura por padrão é a ``default8x16``. É uma 
fonte que, para mim, tem como único defeito a ausencia do caracter ``ã``!

&nbsp;

**OBSERVAÇÃO**  
Se você seguiu todas as configurações indicadas na etapa **400** então sua fonte já está definida
como **lat1-16**. 

&nbsp;

**IMPORTANTE 01**  
As dicas descritas aqui se direcionam para uma instalação SEM UMA INTERFACE GRÁFICA.

&nbsp;

**IMPORTANTE 02**  
As alterações de fonte descritas aqui apenas serão visiveis se você estiver acessando DIRETAMENTE
o computador com a instalação do Arch. Se você tentar alterar fontes do seu terminal através de um 
computador remoto (via SSH por exemplo), o comando será aceito mas no SEU TERMINAL nenhuma
alteração será perceptível pois ele apenas recebe informações "textuais" (não o gráfico renderizado
no computador remoto). Seu terminal apenas pode utilizar fontes que estão instaladas no computador
em que ele está sendo executado. Neste caso... altere as fontes do seu terminal via sua interface 
gráfica (caso esteja usando uma) ou faça isso ANTES de entrar numa sessão SSH.


``` shell
  # Listar todas as fontes de console/terminal disponíveis na sua instalação
  # Fontes assim são geralmente arquivos ".psf" ou ".psfu" e normalmente são 
  # armazenadas em compressão ".gz"
  find / -name "*.psf*" | sort | uniq | less

  # Selecione uma fonte 
  # Não precisa usar o caminho completo. Apenas o nome da fonte.
  # Apenas para seu conhecimento, no Arch as fontes de console ficam armazenadas em 
  # /usr/share/kbd/consolefonts/
  setfont [nome-da-fonte]

  # Mostrar todos os caracteres disponíveis pela fonte
  showconsolefont
```

Ao menos para mim, a primeira vez que usei o comando ``setfont``, ele simplesmente não funcionou!  
Havia tentado definir a fonte **lat1-16** e depois, por puro teste, tentei com a *Lat2-Terminus16* 
e então funcionou sem qualquer problema. Após, rodei novamente o ``setfont lat1-16`` e ele 
funcionou conforme o esperado me dando o aguardado ``ã``.

Apesar de poder alterar a fonte do terminal, tal alteração não será permanente exceto se você
usar algum dos arquivos de configurações para isto. Para entender como o ``bash`` e suas 
configurações funcionam, veja a próxima etapa deste tutorial.
