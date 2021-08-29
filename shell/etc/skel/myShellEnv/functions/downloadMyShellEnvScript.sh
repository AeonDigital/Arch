#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
TARGET_SCRIPTS=()



#
# Efetua o download e a instalação dos scripts alvos conforme as
# informações passadas pelos parametros.
# Os scripts alvo desta ação devem estar definidos no array ${TARGET_SCRIPTS}.
#
#   @param string $1
#   URL do local (diretório) onde estão os scripts a serem baixados.
#
#   @param string $2
#   Endereço completo até o diretório onde os scripts serão salvos.
#
#   @example
#     TARGET_SCRIPTS=("script01.sh" "script02.sh" "script03.sh")
#     downloadMyShellEnvScript "https://myrepo/dir" "~/myShellEnv/"
#
#
downloadMyShellEnvScript() {
  if [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 2 arguments"
  else
    if [ ${#TARGET_SCRIPTS[@]} == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}TARGET_SCRIPTS${NONE}"
    else
      mkdir -p "$2"

      if [ ! -d "$2" ]; then
        errorAlert "${FUNCNAME[0]}" "target directory $2 cannot be created"
      else

        printf "\n${ALERT_INDENT}Baixando arquivos para o diretório: ...\n"
        printf "\n${ALERT_INDENT}${LBLUE}$2${NONE} ...\n"

        for script in "${TARGET_SCRIPTS[@]}"; do
          printf "${ALERT_INDENT} ... ${LBLUE}${script}${NONE} \n"
          curl -s -o "${2}${script}" "${1}${script}"
        done

        printf "${ALERT_INDENT}Finalizado.\n"

      fi
    fi
  fi
}
