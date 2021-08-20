# 630 - Funções

Trata-se da criação de funções personalizadas para atuar rapidamente na utilização de determinados
comandos que não podem simplesmente serem feitos por ``aliases``.  

Nos tópicos a seguir estão exemplos de como preparar o uso das funções que serão escritas em 
arquivos dedicados a cada qual. Note, você pode escrever todas as funções em apenas 1 arquivo e 
então carregar tudo em *1 única chamada* mas por organização é melhor separar coleções de scripts
que tenham um mesmo *assunto*.  



&nbsp;

## 630.1 - Crie um arquivo

Este novo arquivo que você pode nomear como quiser irá receber o conteúdo do script de funções que
você deseja disponibilizar em seu ambiente.  

``` shell
  # Exemplo de criação de novo arquivo usando o *vim*
  vim /etc/bash-[nome-da-funcao|funcao-do-script]
```



&nbsp;

## 630.2 - Dando permissão de execução

Se você não der permissão de execução não será possível usar o script.

``` shell
  # Dando permissão de execução para TODOS os usuários
  chmod 755 /etc/bash.[nome-da-funcao|funcao-do-script]

  # Dando permissão de execução apenas para o usuário criador do arquivo.
  chmod 711 /etc/bash.[nome-da-funcao|funcao-do-script]
```



&nbsp;

## 630.3 - Configurando o seu .bashrc

Se você reparou bem, a orientação deste tutorial é de colocar os scripts que são de uso comum 
dentro do diretório ``/etc`` pois é um local público, mas como é chato ficar evocando comandos 
tendo que passar todo o caminho para o mesmo é possível já utilizarmos o ``~/.bashrc`` para 
facilitar nosso trabalho.  

Há ao menos 2 formas de realizar tal **link**.

``` .bashrc
  # 1. Evocando o script como um todo
  source /etc/bash-[nome-da-funcao|funcao-do-script]

  # 2. Criando uma função que o evoca "on demand"
  nomeDaFuncao() {
    source /etc/bash-[nome-da-funcao|funcao-do-script]
  }
```

Embora pareça que "dá no mesmo", isto não é verdade.  
Há scrips que disponibilizam inúmeras funções para seu uso na sua sessão do ``bash``, e há outros 
que ao serem evocados executam automaticamente alguma ação e nem sempre você quer que tal ação
seja executada no momento que sua sessão iniciou. Neste segundo caso a criação da função é mais
adequado.  
