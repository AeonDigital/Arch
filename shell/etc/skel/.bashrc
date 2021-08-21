#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return



# Carrega os scripts de ambiente
source /etc/bash-variables.sh
source /etc/bash-aliases.sh
source /etc/bash-prompt.sh
source /etc/bash-function-user.sh
source /etc/bash-function-pallete256.sh



# Impede que seja causado um "exit" caso ocorra alguma falha
# de execução de algum comando.
set +e



# Define o estilo do prompt
PS1=$PSTYLE03C