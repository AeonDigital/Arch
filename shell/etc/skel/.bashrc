#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Impede que seja causado um "exit" caso ocorra alguma falha
# de execução de algum comando.
set -euo pipefail
shopt -s inherit_errexit nullglob


# Carrega os scripts de ambiente
source /etc/bash-variables.sh
source /etc/bash-aliases.sh
source /etc/bash-prompt.sh
source /etc/bash-function-pallete256.sh
source /etc/bash-function-user.sh


# Define o estilo do prompt
PS1=$PSTYLE03D
