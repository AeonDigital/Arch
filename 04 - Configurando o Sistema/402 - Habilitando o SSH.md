# 402 - Acesso SSH

Caso sua instalação seja com intenção para um servidor somente texto, e irá querer acessá-lo via 
``SSH`` remotamente instale o pacote ``sshfs``, e habilite (enable) o mesmo para iniciar o serviço 
com o boot. Se você apenas quer usar ``SSH`` para acessar outros servidores remotamente, não 
habilite o mesmo, apenas instale o pacote.

``` shell 
  sudo systemctl enable sshd 
  sudo systemctl restart sshd
```
  Uma vez habilitado, qualquer pessoa que conheça o IP do servidor e tenha credenciais de acesso 
  poderá conectar-se remotamente no mesmo.


**OBSERVAÇÃO**
Neste mesmo tutorial há uma explicação bem mais completa e detalhada sobre como habilitar e 
configurar o SSH. As informações que constam aqui são superficiais e tem objetivo apenas de 
demonstrar o passo mais básico sobre este tipo de serviço.



&nbsp;

## 402.1 - Conheça o IP do servidor

``` shell
  ip addr show

  # Exemplo de saida
  lo:  mtu 16436 qdisc noqueue
   link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
   inet 127.0.0.1/8 scope host lo
   inet6 ::1/128 scope host
      valid_lft forever preferred_lft forever
  eth0:  mtu 1500 qdisc pfifo_fast qlen 1000
   link/ether 00:0C:22:83:79:A3 brd ff:ff:ff:ff:ff:ff
   inet 192.168.10.199/24 brd 192.168.1.255 scope global eth0 
   inet6 fe80::20c:29ff:fe89:79b3/64 scope link
      valid_lft forever preferred_lft forever
  
  # Se quiser apenas as linhas que lhe interessa use
  ip addr show | grep "inet "
```



&nbsp;

## 402.2 - Conectando via SSH com o Windows 

O windows disponibiliza um recurso opcional que é o "Cliente OpenSSH" que permite você efetuar 
conexões ``SSH`` sem precisar aplicativos de terceiros.

Para instalar ele vá em "Configurações" -> "Aplicativos" -> "Recursos Opcionais".
Selecione e instale o "Cliente OpenSSH".


Após, abra um terminal e use:

``` shell
  ssh [user]@[host|ip] 
```
  Após, digite a senha e pronto.


Se precisar informar uma porta diferente da 22 use:

``` shell
  ssh [user]@[host|ip] -p [port]
```
