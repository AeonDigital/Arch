#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return



#
# Carrega os scripts de ambiente
source /etc/bash_users_aliases.sh || true
source /etc/bash_users_prompt.sh || true
source /etc/bash_users_functions.sh || true



#
# Impede que seja causado um "exit" caso ocorra alguma falha
# de execução de algum comando.
set +e



#
# Define o estilo do prompt
PS1=$PSTYLE03D
