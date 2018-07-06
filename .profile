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

alias ssh='start_ssh'
