# 920 - Criando imagem para Docker

Apenas para compartilhar o conhecimento adquirido, deixo aqui registrado um dos inúmeros métodos
pelo qual você pode criar uma imagem a ser usada no Docker. A imagem será feita a partir de uma
instalação do próprio Arch Linux. Conforme você verá, não tem nada demais e o processo, exceto por
alguns *ritos* é muito parecido com uma instalação.  

Usei como base os scripts desenvolvidos por ``Shulhan`` em [seu repositório no GitHub](https://github.com/shuLhan/arch-docker).  
Note que tanto ele quanto eu percebemos que o ``Arch`` está um tanto quanto ``inchado`` e portanto,
a não ser que você seja um expert na arquitetura do Linux ao ponto de conseguir enxugar tudo o que
for realmente desnecessário, dificilmente conseguirá uma imagem realmente enxuta.  

No diretório ``buildimage`` estão os scripts que você precisa usar, após baixa-los para a sua 
máquina basta dar permissão de execução nos mesmos e rodar o ``create_rootfs.sh``. Se você tiver
o Docker instalado e quiser já instalar a imagem gerada pode usar o script ``create_image.sh``.
