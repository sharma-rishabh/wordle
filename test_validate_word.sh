source validate_word.sh

function correct_word () {
    local test_word=world
    local test_dictionary=`echo -e "world\ncrate"` 
    local expected_output=0
    local description="It should return 0 if the entered word is a five letter word with meaning."
    local input="Word : ${test_word}"
    local function_name="validate word"
    local actual_output=$( validate_word ${test_word} "${test_dictionary}" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function incorrect_word () {
    local test_word=abcde
    local test_dictionary=`echo -e "world\ncrate"` 
    local expected_output=1
    local description="It should return 1 if the entered word has no meaning."
    local input="Word : ${test_word}"
    local function_name="validate word"
    local actual_output=$( validate_word ${test_word} "${test_dictionary}" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function short_word () {
    local test_word=word
    local test_dictionary=`echo -e "world\ncrate"` 
    local expected_output=1
    local description="It should return 1 if the entered word is shorter than 5 characters."
    local input="Word : ${test_word}"
    local function_name="validate word"
    local actual_output=$( validate_word ${test_word} "${test_dictionary}" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function long_word () {
    local test_word=bottle
    local test_dictionary=`echo -e "world\ncrate"` 
    local expected_output=1
    local description="It should return 1 if the entered word is longer than 5 characters."
    local input="Word : ${test_word}"
    local function_name="validate word"
    local actual_output=$( validate_word ${test_word} "${test_dictionary}" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function word_with_numbers () {
    local test_word=cat15
    local test_dictionary=`echo -e "world\ncrate"` 
    local expected_output=1
    local description="It should return 1 if the entered word has numbers."
    local input="Word : ${test_word}"
    local function_name="validate word"
    local actual_output=$( validate_word ${test_word} "${test_dictionary}" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}


function validate_word_test_cases () {
    correct_word
    incorrect_word
    short_word
    long_word
    word_with_numbers
}