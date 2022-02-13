function validate_word () {
    local word="$1"
    local dictionary="$2"
    local valid_word=0
    grep "^${word}$" <<< "$dictionary" > /dev/null
    valid_word=$?
    if [[ ${valid_word} -ne 0 ]]
    then
        valid_word=1
    fi
    echo ${valid_word}
}