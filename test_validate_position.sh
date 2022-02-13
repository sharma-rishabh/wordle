source library.sh


function correct_position () {
    local test_word=world
    local test_char=w
    local test_position=0
    local expected_output=0
    local description="It should return 0 if the position of the character is correct."
    local input="Word : ${test_word} , Character : ${test_char} , Position : ${test_position}"
    local function_name=validate_position
    local actual_output=$( validate_position ${test_word} ${test_char} ${test_position} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function incorrect_position () {
    local test_word=world
    local test_char=w
    local test_position=2
    local expected_output=1
    local description="It should return 1 if the position of the character is incorrect."
    local input="Word : ${test_word} , Character : ${test_char} , Position : ${test_position}"
    local function_name=validate_position
    local actual_output=$( validate_position ${test_word} ${test_char} ${test_position} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function validate_position_test_cases () {
    correct_position
    incorrect_position
}