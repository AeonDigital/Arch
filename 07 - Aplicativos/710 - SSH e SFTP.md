# 710 - Configurar o acesso SSH

Liberar o acesso SSH é facil... dificil é fazer de uma forma segura ou minimamente ajustada a
necessidades específicas.

O Arquivo de configuração do SSHD é o ``/etc/ssh/sshd_config``.
No momento ele já vem com várias informações sobre as possíveis configurações mas para facilitar,
busquei uma explicação (em português) sobre as principais configurações que você terá ao menos que
saber que existem para ter uma boa noção do todo.

Fontes:
> http://www.manpagez.com/man/5/sshd_config/
> https://www.vivaolinux.com.br/etc/sshd_config-4/
> https://www.youtube.com/watch?time_continue=534&v=7BEsfupYngE
> https://wiki.archlinux.org/index.php/SFTP_chroot
> https://en.wikibooks.org/wiki/OpenSSH/Cookbook/File_Transfer_with_SFTP


As configurações abaixo estão definidas conforme considero ok para as minhas necessidades que não
são muito avançadas. Se for usá-las, trate de ler com atenção e entender o que está sendo usado
para, se necessário, alterar o que for preciso conforme sua realidade e necessidade de uso.

O SSH assim configurado está preparado para ser acessado usando a porta 22 de qualquer computador
na rede e pode também usar autenticação por chaves público/privadas.
Ninguem pode fazer acesso direto com o usuário ROOT.


``` /etc/ssh/sshd_config
  # Package generated configuration file
  # See the sshd(8) manpage for details



  #
  ## Configurações para acesso em nível de rede
  ###

  ################################################################################
  # Porta padrão usada pelo servidor sshd. 
  # Múltiplas portas podem ser especificadas separadas por espaços.
  #
  # Padrão : 22
  Port 22

  ################################################################################
  # Especifica o endereço IP das interfaces de rede que o servidor sshd servirá requisições. 
  # Múltiplos endereços podem ser especificados separados por espaços. 
  # A opção Port deve vir antes desta opção.
  # 
  # Padrão: o sshd escuta em todos os endereços de rede.
  #ListenAddress 192.168.0.x

  ################################################################################
  # Protocolos aceitos pelo servidor, primeiro será verificado se o cliente é compatível com a 
  # versão 2 e depois a versão 1. Caso seja especificado somente a versão 2 e o cliente seja 
  # versão 1, a conexão será descartada.
  #
  # Padrão: protocolo ssh 1.
  Protocol 2





  #
  ## Formas de autenticação
  ###

  ################################################################################
  # Usa (yes) ou não usa (no) o programa login para efetuar o login do cliente no servidor ssh. 
  # Este programa padrão é considerado inseguro por isto não deve ser usado.
  #
  # Padrão: no
  #UseLogin no

  ################################################################################
  # Permite a autenticação usando o PAM (yes) ou não (no) o padrão é "não".
  #UsePAM no

  ################################################################################
  # Especifica se a autenticação via RSA é permitida (só usado na versão 1 do protocolo ssh). 
  #
  # Padrão: yes
  RSAAuthentication yes

  ################################################################################
  # Especifica os arquivos que contém as chaves privadas do sshd.
  # Lembre-se que o ssh faz a criptografia dos dados usando um par de chaves público/privada.
  HostKey /etc/ssh/ssh_host_rsa_key
  HostKey /etc/ssh/ssh_host_dsa_key

  ################################################################################
  # Especifica se a autenticação usando chave pública é permitida.
  # Note que esta opção se aplica ao protocolo versão 2, apenas.
  #
  # Padrão: yes
  PubkeyAuthentication yes

  ################################################################################
  # Tempo para geração de nova chave do servidor (segundos).
  # O propósito de regeneração de chaves é para evitar descriptografar trafégo capturado em sessões
  # abertas para posteriormente tentar invadir a máquina e roubar as chaves.
  # A chave nunca é armazenada em qualquer lugar. 
  # Se o valor for 0 a chave nunca será regenerada.
  #
  # Padrão: 3600 (segundos; 1 hora)
  KeyRegenerationInterval 1200

  ################################################################################
  # Tamanho da chave gerada. 
  #
  # Padrão: 1024 bits
  ServerKeyBits 1024

  ################################################################################
  # Especifica o arquivo que contém as chaves públicas que podem ser usados para autenticação de 
  # usuários. "%h" especifica o diretório home do do usuário que está usando as chaves públicas 
  # e privadas.
  AuthorizedKeysFile   %h/.ssh/authorized_keys

  ################################################################################
  # Se "yes", irá ignorar os arquivos ~/.rhosts e ~/.shosts.
  IgnoreRhosts yes

  # Para que funcione você precisa que as chaves host estejam em /etc/ssh/ssh_known_hosts
  RhostsRSAAuthentication no
  # Similar ao protocolo versão 2
  HostbasedAuthentication no

  ################################################################################
  # Ignora (yes) ou não (no) os arquivos ~/.ssh/known_hosts quando for usado para a opção 
  # RhostsRSAAuthentication. 
  # Se você não confia neste mecanismo ajuste esta opção para yes.
  #IgnoreUserKnownHosts yes





  #
  ## Regras de sessão e autenticação
  ###

  ################################################################################
  # Especifica o número máximo de tentativas de autenticação permitidas por conexão. Uma vez que 
  # o número de falhas chega a metade desse valor, falhas adicionais são registrados. 
  #
  # Padrão: 6
  MaxAuthTries 4

  ################################################################################
  # Especifica o número máximo de sessões abertas permitidas. 
  #
  # Padrão: 10
  MaxSessions 5

  ################################################################################
  # Define o número máximo de conexões *não autenticadas* que o daemon SSH irá gerenciar antes de
  # começar a recusar ativamente novos clientes.
  # Quando o SSH cliente inicia uma conexão, mas ainda não se logou, o servidor SSH considera
  # este tipo de conexão como *não autenticada*.
  #
  # Se você especificar um valor inteiro para este parâmetro, tal valor será o número máximo de 
  # conexões aguardando autenticação que o daemon irá permitir. Qualquer conexão vinda após esta
  # será recusada.
  # Você pode usar a seguinte notação "aguardando:taxa:maximo" para especificar uma forma mais 
  # sofisticada para este controle
  # 
  # aguardando: Número de conexões que podem estar na porta de entrada sem que nenhuma ação seja 
  #             tomada pois será o número considerado aceitável de conexões não autenticadas. A
  #             partir deste número, a regra especificada em "taxa" passará a ser aplicada.
  # taxa:       Quando o número de conexões pendentes atinje o número especificado em "aguardando"
  #             cada nova conexão realizada por novos clientes terão uma chance percentual igual a
  #             "taxa" de serem recusadas sumariamente. Isto ocorrerá com todas as novas conexões
  #             até atinjir o valor especificado no parametro "máximo". 
  # maximo:     Número máximo de conexões não autenticadas simultâneas que o daemon está 
  #             configurado para gerenciar. A partir deste número nenhum outro cliente conseguirá 
  #             se logar até que a fila seja resolvida.
  #
  # Padrão: 10
  MaxStartups 5

  ################################################################################
  # Tempo máximo para fazer login no sistema antes da conexão ser fechada.
  # O tempo e informado em segundos. 
  # Se o valor for 0 não tem limite.
  # 
  # Padrão: 30 (segundos)
  LoginGraceTime 30

  ################################################################################
  # Se a opção PasswordAuthentication for usada, permite (yes) ou não (no) login sem senha. 
  # Não é recomendado habilitar (yes) essa opção.
  #
  # Padrão: no
  PermitEmptyPasswords no

  ################################################################################
  # Se a PasswordAuthentication for usada, permite (yes) ou não (no) login usando senha. 
  #
  # Padrão: yes
  PasswordAuthentication yes

  #Kerberos options
  #KerberosAuthentication no
  #KerberosGetAFSToken no
  #KerberosOrLocalPasswd yes
  #KerberosTicketCleanup yes

  #GSSAPI options
  #GSSAPIAuthentication no
  #GSSAPICleanupCredentials yes

  ################################################################################
  # Está opção permite (yes) ou nega (no) se a autenticação desafio-resposta será aceita via PAM 
  # por exemplo. 
  #
  # Padrão: yes
  ChallengeResponseAuthentication no




  #
  ## Configurações para o login
  ###

  ################################################################################
  # Mostra uma mensagem antes do nome de login.
  #Banner /etc/issue.net

  ################################################################################
  # Mostra (yes) ou não (no) a mensagem em /etc/motd no login.
  #
  # Padrão: no
  PrintMotd yes

  ################################################################################
  # Mostra (yes) ou não (no) a date e hora do último login do usuário.
  #
  # Padrão yes
  PrintLastLog yes

  ################################################################################
  # ssh Permite (yes) ou nega (no) que o usuário root acesse remotamente o servidor. 
  # Por segurança é indicado deixar desabilitada.
  PermitRootLogin no

  ################################################################################
  # Checa por permissões de dono dos arquivos e diretório de usuário antes de fazer o login. 
  # É muito recomendável para evitar riscos de segurança com arquivos lidos por todos os usuários.
  StrictModes yes

  ################################################################################
  # Lista de usuários que o ssh permite acessar remotamente o servidor separados por espaços.
  #
  # Exemplo: AllowUsers usernameA usernameB
  #AllowUsers

  ################################################################################
  # Está opção especifica quais usuários não terão permissão de acesso ao servidor sshd. 
  # A sintaxe é a mesma de AllowUsers, pode especificar vários usuários separados por espaço.
  #DenyUsers

  ################################################################################
  # Especifica uma lista de groupos que terão acesso permitido ao sshd.
  # Se o usuário estiver contido no grupo especificado nesta opção então seu acesso será liberado.
  #AllowGroups

  ################################################################################
  # Especifica um lista de grupos que terão seu acesso negado ao sshd.
  # Se o usuário estiver contido no grupo espeficado nesta opção seu acesso será negado ao 
  # servidor sshd.
  #DenyGroups





  #
  ## Outras configurações
  ###

  ################################################################################
  # Permite ao programa cliente passar variáveis de ambiente do tipo Locale.
  AcceptEnv LANG LC_*

  ################################################################################
  # Permite (yes) ou não (no) o envio de pacotes keepalive (para verificar se o cliente responde. 
  # Isto é bom para fechar conexões que não respondem mas também podem fechar conexões caso não 
  # existam rotas para o cliente naquele momento (é um problema temporário). Colocando esta opção 
  # como "no" por outro lado pode deixar usuários que não tiveram a oportunidade de efetuar o 
  # logout do servidor dados como "permanentemente conectados" no sistema. Esta opção deve ser 
  # ativada/desativada aqui e no programa cliente para funcionar. Caso queira manter uma conexão 
  # aberta mesmo estando inativa, habilite (yes) no servidor e no cliente está opção.
  TCPKeepAlive yes

  ################################################################################
  # Quando ativado permite comprimir os dados para envio ganhando performance em servidores 
  # acessados via internet.
  Compression yes

  ################################################################################
  # Está opção especifica se será criado um processo filho sem privilégios. Após a autenticação 
  # bem-sucedida, outro processo será criado que tem o privilégio de o usuário autenticado. O 
  # objetivo da separação de privilégio é para evitar a escalonamento de privilégios, qualquer 
  # tipo de corrupção no âmbito dos processos sem privilégios. 
  #
  # Padrão: yes
  UsePrivilegeSeparation yes

  ################################################################################
  # Indica facilidade e nível logs do sshd que aparecerão no syslogd ou no rsyslog. Você pode 
  # alterar conforme sua necessídade.
  #SyslogFacility AUTH
  #LogLevel INFO

  ################################################################################
  # Especifica se o encaminhamento pelos dispositivos tun/tap é permitido, criando um rede 
  # ponto-a-ponto usando ssh, ou seja, permite ou não a criação de túneis cifrados com sshd.
  #PermitTunnel yes

  ################################################################################
  # Permite (yes) ou não (no) o redirecionamento de conexões X11. A segurança do sistema não é 
  # aumentada com a desativação desta opção, outros métodos de redirecionamento podem ser usados. 
  # Isso permite ou nega a execução de aplicativos gráficos no servidor ssh.
  X11Forwarding no

  ################################################################################
  # Especifica o número do primeiro display que será usado para o redirecionamento X11 do ssh. 
  # Por padrão é usado o display 10 como inicial para evitar conflito com display X locais.
  #
  # Padrão: 10
  X11DisplayOffset 10





  #
  ## Sub Sistemas
  ###

  ################################################################################
  # Ativa o subsistema de ftp seguro. 
  # Habilite apenas se você tem noção dos riscos que isto envolve.
  # O tutorial que acompanha este arquivo possui informações sobre como usar cada uma das opções e 
  # também como configurar um acesso controlado a um SFTP.
  #Subsystem sftp internal-sftp

  #Match Group sftponly
    # Restringe os usuários a navegarem unicamente em seus próprios diretórios "home"
    #ChrootDirectory %h
    # Desabilita o grupo de usuários de executar programas de interface gráfica.
    #X11Forwarding no
    # Desativa o encaminhamento TCP e limita a exposição de outros aplicativos internos ao grupo.
    #AllowTcpForwarding no
    # No login, faz com que o sistema execute o processo sftp interno.
    #ForceCommand internal-sftp
```




## 710.1 - SFTP

O SSH pode ser usado para configurar um SFTP e assim você pode disponibilizar este tipo de acesso
entre um grupo de usuários que você desejar.
Para isto, siga as orientações abaixo tiradas direto da wiki do Arch Linux



### 710.1.1 - Rápido e sujo

Se você deseja apenas habilitar o acesso ao servidor para todos os usuários que possuam credenciais
de acesso ao mesmo, basta você habilitar a configuração ``internal-sftp`` conforme é mostrado 
abaixo.

``` /etc/ssh/sshd_config
  Subsystem sftp internal-sftp
```

Reinicie o serviço para que as alterações passem a valer.
``` shell
  systemctl restart sshd
```

Apenas com isto qualquer usuário conectado poderá navegar por todo o sistema de diretórios, criar, 
alterar e excluir qualquer arquivo que suas credenciais permitam.
Em muitos casos isto não é interessante pois você não quer que um usuário externo saiba sobre o 
sistema mais do que ele deveria mesmo que ele não possa alterar arquivos importantes. Parte da 
segurança envolve sigilo e o desconhecimento sobre o todo.



### 710.1.2 - Lento e seguro

Se você deseja configurar um acesso mais controlado para os usuários do SFTP então precisará "sujar
as mãos" com algumas configurações adicionais.

Primeiramente, adicione no ``/etc/ssh/sshd_config`` a seguinte configuração:

``` /etc/ssh/sshd_config
  # Habilita o uso do sftp
  Subsystem sftp internal-sftp

  # Indica que as configurações a seguir devem ser aplicadas
  # ao grupo de usuários "sftponly"
  Match Group sftponly
    # Restringe os usuários a navegarem unicamente em seus próprios diretórios "home"
    # No entanto, estes diretórios precisam pertencer ao usuário "root" (veja mais abaixo)
    ChrootDirectory %h
    # Desabilita o grupo de usuários de executar programas de interface gráfica.
    X11Forwarding no
    # Desativa o encaminhamento TCP e limita a exposição de outros aplicativos internos ao grupo.
    AllowTcpForwarding no
    # No login, faz com que o sistema execute o processo sftp interno.
    ForceCommand internal-sftp
```

Reinicie o serviço para que as alterações passem a valer.
``` shell
  systemctl restart sshd
```



#### 710.1.2.1 - Criando um grupo de usuários para uso do SFTP

Confirme visto nas configurações acima, para melhor gerenciar os usuários que irão usar o SFTP, 
você deve primeiro criar um grupo de usuários no qual todos aqueles que devem ter acesso ao SFTP 
deverão pertencer. Neste tutorial o nome deste grupo será o ``sftponly`` mas, naturalmente, você 
pode escolher outro nome

``` shell
  groupadd sftponly
```



#### 710.1.2.2 - Criando e configurando usuários para o grupo SFTP

Abaixo estão as configurações que você deve utilizar para ajustar corretamente os usuários que 
ganharão acesso ao SFTP dentro do grupo criado.

``` shell
  # Crie o usuário que deseja permitir o acesso ao SFTP e defina uma senha para ele.
  useradd -m [username]
  passwd [username]

  # Adicione-o no grupo definido anteriormente.
  usermod -G sftponly [username]

  # Transfira o diretório "home" do novo usuário para o usuário "root"
  chown root:root /home/[username]

  # Dê acesso pleno ao usuário para seu diretório "home"
  chmod 755 /home/[username]
```

Uma vez que o diretório ``/home/[username]`` agora pertence ao usuário ``root``, o usuário novo 
não pode criar arquivos ou outros diretórios neste local.
Para permitir que o novo usuário consiga usar este espaço que está sendo fornecido para ele, você 
precisa seguir os seguintes passos:

``` shell
  mkdir /home/[username]/public
  chown [username]:[username] /home/[username]/public
```

Isto criará um diretório ``public`` onde o novo usuário poderá enfim usar livremente.
Se você desejar, poder criar um local privativo para o mesmo usuário, protegido assim dos demais
usuários use os comandos a seguir:

``` shell
  mkdir /home/[username]/private
  chown [username]:[username] /home/[username]/private
  chmod 700 /home/[username]/private
```
