#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

promptUser "-- Carregar personalização?"
if [ "$PROMPT_RESULT" = "1" ]; then

    # Carrega os scripts de ambiente
    source /etc/bash-variables.sh || true
    source /etc/bash-aliases.sh || true
    source /etc/bash-prompt.sh || true
    source /etc/bash-function-pallete256.sh || true
    source /etc/bash-function-user.sh || true



    # Impede que seja causado um "exit" caso ocorra alguma falha
    # de execução de algum comando.
    set +e



    # Define o estilo do prompt
    PS1=$PSTYLE03D
else
    echo "Simples"
fi
