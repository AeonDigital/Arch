# 604 - Usando cores em textos

Usando o Bash você pode alterar a cor de textos bastando para isto entender como indicar como um
determinado texto deve ser apresentado. Para isto é preciso conhecer quais são as configurações
possíveis de serem usadas.
Neste tópico estão expostas as informações que você deve conhecer para efetuar as manipulações
que desejar.



&nbsp;

## 604.1 - Modificadores

Há 3 conjuntos de motificadores que podem ser usados na composição da estilização de uma mensagem
de texto; em cada ``família``, cada ítem é representado por um dígito específico.
Na composição do código que precede o texto que você deseja que herde aquele estilo você precisa
definir o número que corresponderá a cada um dos modificadores na ordem correta.


&nbsp;

Os modificadores são:
- Atributos
- Cor de Fonte
- Cor de Fundo

Assim sendo, o comando a ser usado deve corresponder à seguinte estrutura:
\e[ Atributo ; Fonte ; Fundo m

Os espaços adicionados na exposição acima servem apenas para facilitar o entendimento e não devem
existir quando você compor um código de estilo de fato.
Importante notar que o início é sempre com os caracteres ``\e`` e finaliza sempre com a letra ``m``.

&nbsp;

**Exemplo:**
\e[0;93;44m Texto estilizado
O código acima exibirá o texto sem nenhum atributo especial onde a cor da fonte é amarelo claro e
o fundo é azul.



&nbsp;

### 604.1.1 - Atributos

- 0:  Remove todos os modificadores; Sejam atributos, cor de fonte ou cor de fundo.
- 1:  Negrito*
- 2:  Dim*
- 4:  Sublinhado*
- 5:  Piscando*
- 7:  Inverte a seleção de cor de fonte e cor de fundo
      No exemplo acima o código \e[0;93;44] exibe um texto onde a cor da fonte é amarelo claro
      e o fundo é azul, já o código \e[7;93;44] inverterá a seleção criando um texto onde
      a cor da fonte será azul e o fundo será amarelo.
- 8:  Oculto*; Use para ocultar informações sensíveis
- 21: Remove o Negrito*
- 22: Remove o Dim*
- 24: Remove o Sublinhado*
- 25: Remove o Piscado*
- 27: Remove a Inversão*
- 28: Remove o Oculto*

*:  Estes ítens não puderam ser testados direto no terminal via VM possivelmente por que
    necessitavam de uma fonte que correspondesse a tais atributos.



&nbsp;

### 604.1.2 - Cor da fonte

- 39: Padrão        (usualmente verde, branco ou cinza claro)
- 30: Preto         (combine com um fundo colorido para obter um bom resultado)
- 31: Vermelho      (Não use com um fundo verde)
- 32: Verde
- 33: Amarelo
- 34: Azul
- 35: Púrpura
- 36: Ciano
- 37: Cinza claro
- 90: Cinza escuro
- 91: Vermelho claro
- 92: Verde claro
- 93: Amarelo claro
- 94: Azul claro
- 95: Púrpura claro|Pink
- 96: Ciano claro
- 97: Branco



&nbsp;

### 604.1.3 - Cor do fundo

- 49:  Padrão               (usualmente preto ou azul)
- 40:  Preto
- 41:  Vermelho
- 42:  Verde
- 43:  Amarelo
- 44:  Azul
- 45:  Púrpura
- 46:  Ciano
- 47:  Cinza claro          (não use com fonte branca)
- 100: Cinza escuro         (não use com fonte preta; Aparenta não funcionar)
- 101: Vermelho claro
- 102: Verde claro          (não use com fonte branca)
- 103: Amarelo claro        (não use com fonte branca)
- 104: Azul claro           (não use com fonte amarelo clara)
- 105: Púrpura claro|Pink   (não use com fontes claras)
- 106: Ciano claro          (não use com fonte branca)
- 107: Branco               (não use com fontes claras)



&nbsp;

### 604.2 - Variáveis prontas

Você pode usar as variáveis abaixo no seu Bash para já ter os códigos de cada uma das cores prontas
para uso. Nenhuma delas usa um fundo colorido exceto o preto, que, para poder ser lido, usa a cor
'cinza claro' como fundo para que o contraste permita sua leitura.


**Obs**
- ``D`` indica ``Dark``
- ``L`` indica ``Light``

```shell
  NONE='\e[0;37;40m'      # reseta o uso da respectiva cor

  BLACK='\e[0;30;47m'
  DGREY='\e[0;90;40m'
  LGREY='\e[0;37;40m'     # Esta é a cor que costuma ser padrão para os textos dos terminais
  WHITE='\e[0;97;40m'

  RED='\e[0;31;40m'
  LRED='\e[0;91;40m'

  GREEN='\e[0;32;40m'
  LGREEN='\e[0;92;40m'

  YELLOW='\e[0;33;40m'
  LYELLOW='\e[0;93;40m'

  BLUE='\e[0;34;40m'
  LBLUE='\e[0;94;40m'

  PURPLE='\e[0;35;40m'
  LPURPLE='\e[0;95;40m'

  CYAN='\e[0;36;40m'
  LCYAN='\e[0;96;40m'


  # Exemplo de uso:
  echo "${LRED}Este texto estará representado em vermelho claro${NONE}, ${GREEN}e este em verde${NONE}"
```
