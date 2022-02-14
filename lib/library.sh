POSITION_CORRECT=0
CHARACTER_PRESENT=1
CHARACTER_ABSENT=2

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NORMAL='\033[0m'


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

function validate_position () {
    local word=$1
    local char=$2
    local position=$3
    local return_status=1

    if [[ ${word:$position:1} == $char ]]
    then 
        return_status=0
    fi

    echo $return_status
}

function set_char_values () {
    local orignal_word=$1
    local guessed_word=$2

    local char_values

    local word_length=$(( ${#guessed_word} - 1 ))
    
    for index in `seq 0 1 ${word_length}`
    do
        local char=${guessed_word:$index:1}
        local valid_char=$( validate_char ${orignal_word} ${char} )
        if [[ $valid_char == 0 ]]
        then
            local valid_position=$( validate_position ${orignal_word} ${char} ${index} )
            if [[ ${valid_position} == 0 ]]
            then
                char_values+=$POSITION_CORRECT
                continue
            fi
            char_values+=$CHARACTER_PRESENT
            continue
        fi
        char_values+=$CHARACTER_ABSENT
    done
    echo $char_values
}


function get_conclusion () {
    local guessed_word=$1
    local assigned_values=$2

    local concluded_word

    local word_length=$(( ${#guessed_word} - 1 ))

    for index in `seq 0 1 ${word_length}`
    do
        local char=${guessed_word:$index:1}
        local value=${assigned_values:$index:1}

        if [[ ${value} == $POSITION_CORRECT ]]
        then
            concluded_word+="${GREEN}${char}"
            continue
        fi
        
        if [[ ${value} == ${CHARACTER_PRESENT} ]]
        then
            concluded_word+="${YELLOW}${char}"
            continue
        fi
        
        concluded_word+="${NORMAL}${char}"
    done

    echo "$concluded_word"
    
    if [[ $assigned_values == "00000" ]]
    then
        return 1
    fi

    return 0
}

function play_wordle () {
    local orignal_word=$1
    local dictionary="$2"

    local guessed_word
    local is_guess_correct
    local prepared_output

    local chances=${#orignal_word}

    while [[ ${chances} -gt 0 ]]
    do
        echo -e "\nYou have ${chances} chances left.\n"

        read guessed_word
        
        local is_word_valid=$( validate_word $guessed_word "$dictionary" )
        if [[ $is_word_valid == 1 ]]
        then
            echo "${guessed_word} is not a five letter word."
            continue
        fi
        
        local guess_analysis=$( set_char_values $orignal_word $guessed_word )
        prepared_output=$( get_conclusion $guessed_word $guess_analysis )
        is_guess_correct=$?
        
        echo -e "$prepared_output${NORMAL}"
        
        if [[ $is_guess_correct == 1 ]]
        then
            return 0
        fi
        chances=$(( $chances - 1 ))
    done
    return 1
}


function get_random_word () {
    local dictionary="$1"

    local total_words=$( grep -c '.*' <<< "${dictionary}" )
    local random_number=$( jot -r 1 1 ${total_words} )

    local random_word=$( head -n $random_number <<< "${dictionary}" | tail -n1 )
    echo "$random_word"
}



function main () {
    local dictionary=$( cat $1 )

    local orignal_word=$( get_random_word "${dictionary}")

    echo "Welcome to wordle start guessing five letter words."

    local result="Sorry!! You're out of luck today. Word is : ${orignal_word}"

    play_wordle "${orignal_word}" "${dictionary}"
    chances_exhausted=$?

    if [[ $chances_exhausted == 0 ]]
    then
        result="Congratulations!! Your guess is correct."
    fi

    echo -e "\n$result\n"

}
