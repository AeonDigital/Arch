# 603 - Funcionamento

Nesta etapa vamos estar sempre lidando com arquivos de script que serão, em algum momento, 
executados pelo Linux e estes trarão variáveis de ambiente e configurações para o mesmo.  
A aparência do prompt do ``bash`` é apenas o elemento visual mais explicito que você pode 
configurar mas há também variáveis e funções que você pode definir e aliases de comandos que 
você pode criar para facilitar sua vida.  

A princípio, como você verá, tudo neste tutorial poderia ser inserido direto dentro do script 
``/etc/profile`` mas esta seria uma má ideia.  

Há configurações que você QUER que sejam globais quando são importantes para TODOS os usuários
mas há algumas que não fazem sentido (como apelidos para comandos) pois tratam-se de questões
realmente pessoais e forçar certas configurações pode trazer mais problemas do que resolve-los.  

Para entender o momento de execução de cada script tenha em mente que, quando ocorre o início
de um novo ``bash`` a partir do login de um usuário, a seguinte ordem de execução será realizada:  
- /etc/profile
- /etc/bash.bachrc
- ~/.bash_profile | ~/.bash_login | ~/.profile

E quando ocorre o início de uma nova sessão sem login ocorrerá a execução dos seguintes arquivos:  
- /etc/bachrc
- ~/.bashrc



&nbsp;

## 603.1 - Início

Usuário   : root  
Local     : /etc/profile  
Execução  : Ao iniciar uma nova sessão.  


Este é o primeiro script executado por todas as sessões.  
Não é uma boa ideia alterar este arquivo sem saber bem o que está fazendo mas se você quiser que 
alguma configuração ou variável fique por padrão disponível a qualquer usuário (incluindo o root)
é aqui que você deve defini-la.



&nbsp;

## 603.2 - Mensagem de boas vindas

Usuário		: root  
Local     : /etc/bash.bachrc  
Execução  : Ao iniciar uma nova sessão.  


Ao iniciar o ``bash`` com um login este script é executado em seguida e não se repete ao iniciar 
outras seções sem login. Ele é executado tanto pelo usuário ``root`` quanto pelos demais, 
portanto as configurações setadas aqui valerão para todos.  

Se você quer adicionar uma mensagem de boas vindas, ou de abertura de sessão este é o local ideal 
para adicionar pois ela aparecerá apenas ao abrir a sessão com cada usuário com seu login.  

Para configurar uma mensagem que depois pode ser alterada de forma mais livre crie um arquivo 
externo, por exemplo ``/etc/bash-message-wellcome`` e escreva dentro dele a mensagem que você deseja
utilizar (lembre-se que ela será mostrada SEMPRE que um usuário se logar no sistema).  
A escolha do diretório ``etc`` é por que neste local é **público** e pode ser acessado pelos demais
usuários.  

Após definir sua mensagem no arquivo externo insira dentro do arquivo ``/etc/bash.bashrc`` as 
seguintes instruções.  

``` /etc/bash.bashrc
  # Mensagem de Boas Vindas
  clear
  echo  " "
  cat /etc/bash-message-wellcome
  echo  ""
  date +"          %A, %d de %B - %Y [%T (%Z)]"
  echo  "          Bem Vind@ $USER  :)"
  echo  "          Você está em : \"${PWD}\""
  echo  ""
```

Dos comandos acima, o único realmente necessário para mostrar a mensagem de boas vindas configurada
é o ``cat /etc/bash-message-wellcome``. O restante foi adicionado ali apenas como sugestão.  



&nbsp;

## 603.3 - Configurando o início de uma sessão 

Usuário   : [user]  
Local     : ~/.bash_profile  
Execução  : Quando um usuário faz login.  


Uma vez que este script será executado somente no momento do login do novo usuário e, em 
contrapartida, o arquivo ``~/.bashrc`` será iniciado sempre que houver o ``switch`` de um usuário
para o outro, o ideal é você configurar este arquivo com um simples comando para que ele execute
o ``~/.bashrc`` quando evocado.  
Isto fará com que o ``~/.bashrc`` possa concentrar todas as configurações pessoais e fará também 
com que ele seja executado sempre que um usuário efetuar o login.  

Adicione dentro do ``~/.bash_profile`` o seguinte comando:  

``` .bash_profile
  source ~/.bashrc
```



&nbsp;

## 603.4 - Personalizando a sua sessão

Usuário   : [user]  
Local     : ~/.bashrc  
Execução  : Quando um usuário inicia sua sessão sem login.  


Finalmente, entendendo com funciona a execução lógica dos arquivos de configuração, podemos iniciar
a personalização do nossa sessão de trabalho.  


**Importante**  
A primeira coisa, a observar é a instrução que já deve estar no seu arquivo.  
Não remova-a se não souber o que está fazendo!

``` .bashrc
  # If not running interactively, don't do anything
  [[ $- != *i* ]] && return
```

Neste arquivo é que você adicionará toda a personalização que você desejar para sua sessão.  
Nos próximos passos há exemplos sobre cada possibilidade a ser explorada.
