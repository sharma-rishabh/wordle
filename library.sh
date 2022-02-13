function validate_word () {
    local word="$1"
    local dictionary="$2"
    local valid_word
    grep "^${word}$" <<< "$dictionary" > /dev/null
    valid_word=$?
    if [[ ${valid_word} -ne 0 ]]
    then
        valid_word=1
    fi
    echo ${valid_word}
}

function validate_char () {
    local word=$1
    local char=$2
    local word_length=$(( ${#word} - 1 ))
    local char_found

    
    for index in `seq 0 1 ${word_length}`
    do
        if [[ "${word:$index:1}" == "$char" ]]
        then
            char_found=0
            break
        fi
        char_found=1
    done
    echo $char_found
}