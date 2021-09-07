start_ssh(){
    ARGS=$*
    for argument in ${ARGS}; do
        if [[ ${argument} == *\.* ]];then
            TITLE=${argument}
            break
        fi
    done
    COL_STR=$(echo "${TITLE}" |md5)
    RED=$(echo $(((0x${COL_STR%% /}*-1))) |cut -c 2-4)
    GREEN=$(echo $(((0x${COL_STR%% /}*-1))) |cut -c 5-7)
    BLUE=$(echo $(((0x${COL_STR%% /}*-1))) |cut -c 8-10)

    while true; do
        if [ "${RED}" -gt "255" ];then
            let RED=${RED}-100
        fi

        if [ "${GREEN}" -gt "255" ];then
            let GREEN=${GREEN}-100
        fi

        if [ "${BLUE}" -gt "255" ];then
            let BLUE=${BLUE}-100
        fi

        if [ "${RED}" -lt "256" ] && [ "${GREEN}" -lt "256" ] && [ "${BLUE}" -lt "256" ]; then
            break
        fi
    done
    echo -ne "\033]6;1;bg;red;brightness;${RED}\a"
    echo -ne "\033]6;1;bg;green;brightness;${GREEN}\a"
    echo -ne "\033]6;1;bg;blue;brightness;${BLUE}\a"
    echo -ne "\033]0;${TITLE}\007"
    /usr/bin/ssh ${ARGS}
}

refresh_prompt (){
  BRANCH=$(git branch --show-current 2>/dev/null)
  if ! [ -z "${BRANCH}" ];then
    if [ "${BRANCH}" == "master" ];then
      PS1GIT="\[\e[1m\]$(git config --get remote.origin.url)\[\e[0m\] \[\e[31m\]${BRANCH}\[\e[0m\] "
    else
      PS1GIT="\[\e[1m\]$(git config --get remote.origin.url)\[\e[0m\] \[\e[92m\]${BRANCH}\[\e[0m\] "
    fi
  else
    PS1GIT=""
  fi
  PS1="\[\e[32m\]$(date +"%d %b %H:%M:%S")\[\e[0m\] \[\e[36m\]$(pwd)\[\e[0m\] ${PS1GIT}# "
}

alias ssh='start_ssh'

PROMPT_COMMAND=refresh_prompt
