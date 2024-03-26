source $(dirname "${0}")/functions_library.sh

# Main
[[ $- =~ x ]] && BASHOPTION='-x '
ORIG_ARGS="${@}"
ENV_LIST=$(get_envname_list "${ORIG_ARGS}")
NEW_ARGS=$(clean_arguments '--envname' "${ENV_LIST}" "${ORIG_ARGS}" | xargs)
IFS=' ' read -r -a LOOP_LIST <<< "${ENV_LIST}"

[[ $(echo "${ENV_LIST}" | wc -w) -gt 1 ]] && echo
for i in "${!LOOP_LIST[@]}"
do
	sleep "${i}"
	if [[ $(echo "${ENV_LIST}" | wc -w) -gt 1 ]]
	then
		echo "Executing: bash ${BASHOPTION}$(echo "${0}" | sed 's|play_||') --envname "${LOOP_LIST[i]}" "${NEW_ARGS}" &>/dev/null &"
		nohup bash ${BASHOPTION}$(echo "${0}" | sed 's|play_||') --envname "${LOOP_LIST[i]}" "${NEW_ARGS}" &>/dev/null &
	else
		bash ${BASHOPTION}$(echo "${0}" | sed 's|play_||') --envname "${LOOP_LIST[i]}" "${NEW_ARGS}"
	fi
done
[[ $(echo "${ENV_LIST}" | wc -w) -gt 1 ]] && echo "Please wait"
wait
