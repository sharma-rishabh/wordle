YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NORMAL='\033[0m'

function exact_match () {
    local test_word=world
    local test_assigned_values=00000
    local expected_output="${GREEN}w${GREEN}o${GREEN}r${GREEN}l${GREEN}d"
    local description="It should output the word with all green text as all the characters are in right position."
    local function_name=get_conclusion
    local input="Word : $test_word , Assigned Values : ${test_assigned_values}"
    local actual_output=$( get_conclusion "$test_word" "$test_assigned_values" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function no_match () {
    local test_word=world
    local test_assigned_values=22222
    local expected_output="${NORMAL}w${NORMAL}o${NORMAL}r${NORMAL}l${NORMAL}d"
    local description="It should output the word with all white text as all characters guessed are wrong."
    local function_name=get_conclusion
    local input="Word : $test_word , Assigned Values : ${test_assigned_values}"
    local actual_output=$( get_conclusion "$test_word" "$test_assigned_values" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function few_match () {
    local test_word=world
    local test_assigned_values=21201
    local expected_output="${NORMAL}w${YELLOW}o${NORMAL}r${GREEN}l${YELLOW}d"
    local description="It should output the word with all white text as all characters guessed are wrong."
    local function_name=get_conclusion
    local input="Word : $test_word , Assigned Values : ${test_assigned_values}"
    local actual_output=$( get_conclusion "$test_word" "$test_assigned_values" )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}


function get_conclusion_test_cases () {
    exact_match
    no_match
    few_match
}