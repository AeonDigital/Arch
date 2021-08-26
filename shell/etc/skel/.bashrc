#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return



#
# Carrega os scripts de ambiente
source ~/myBashConfig/aliases.sh || true
source ~/myBashConfig/prompt.sh || true
source ~/myBashConfig/functions.sh || true



#
# Impede que seja causado um "exit" caso ocorra alguma falha
# de execução de algum comando.
set +e



#
# Define o estilo do prompt
PS1=$PSTYLE03D




# Criar estrutura em 'mybash'
#  onde os itens 'my_' são exclusivos do usuário e jamais serão alterados
#  pelo sistema de atualização!
#- 01_aliases.sh
#- 01_my_aliases.sh
#- 02_variables.sh
#- 02_my_variables.sh
#- 03_prompt.sh
#- 03_my_prompt.sh
#- 04_functions.sh
#- 04_my_functions.sh
