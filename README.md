 Dominando o Linux
===================

> [Aeon Digital](http://aeondigital.com.br)  
> rianna@aeondigital.com.br

Neste repositório pretendo meramente expor informações que estou coletando
sobre o ambiente Linux.  
Não há grandes pretenções e o aprendizado vem DO ZERO.

Antes de iniciar este repositório meu maior contato com o Linux era devido a
necessidades alheias a minha vontade. Eu sempre soube que este dia chegaria
e eu tratei de me preparar para documentar cada passo do que fui aprendendo
ao longo do caminho.

Espero que quem aproveite este material se divirta e aprenda tanto quanto
eu mesma.


&nbsp;
&nbsp;


_______________________________________________________________________________

## Shut up and install 

Use o boot do Arch na máquina alvo e cegamente use os comandos:  

``` shell
  # pura comodidade para facilitar o uso de teclados pt-BR
  loadkeys br-abnt2

  # faz download do script de instalação; dá permissão de execução e executa-o
  curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/install.sh
  chmod u+x install.sh
  ./install.sh
```


&nbsp;
&nbsp;


_______________________________________________________________________________

## Fonte de informações

Obviamente catei na internet vários artigos, vídeos e demais fontes de
informações capazes de me oferecer suporte necessário para os testes e para
criar minhas próprias versões daquele conhecimento... sabidamente, nada se
cria, tudo se transforma.


### Pacotes do Arch Linux
> https://archlinux.org/packages/



### Sobre a instalação como um todo
- [Diolinux](https://www.youtube.com/watch?v=4orYC5ARfn8)
            (https://www.diolinux.com.br/2019/07/como-instalar-arch-linux-tutorial-iniciantes.html)
- [Akitando](https://www.youtube.com/watch?v=epiyExCyb2s)
- [Remontti](https://blog.remontti.com.br/1911)
- [wiki.archlinux](https://wiki.archlinux.org/index.php/Pacman_(Portugu%C3%AAs) )


### NetworkManager
> https://wiki.archlinux.org/index.php/NetworkManager_(Portugu%C3%AAs)


### CHMOD
> https://ss64.com/bash/chmod.html


### Variáveis e configurações do bash
> https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
> https://intoli.com/blog/exit-on-errors-in-bash-scripts/


### Arte ASCII
> http://patorjk.com/software/taag/


### Configurar, compilar e instalar
> https://klebermota.eti.br/2016/11/25/a-magica-por-tras-dos-comandos-configure-make-make-install/



_______________________________________________________________________________

## Licença

Este tutorial está licenciado sob a [Licença MIT](LICENSE).
