
function char_is_present () {
    local test_word="world"
    local test_char="r"
    local expected_output=0
    local description="It should return 0 if character is present in the given word."
    local input="Word : ${test_word} , Char : ${test_char}"
    local function_name=validate_char
    local actual_output=$( validate_char ${test_word} ${test_char} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function char_is_absent () {
    local test_word="world"
    local test_char="a"
    local expected_output=1
    local description="It should return 1 if character is absent in the given word."
    local input="Word : ${test_word} , Char : ${test_char}"
    local function_name=validate_char
    local actual_output=$( validate_char ${test_word} ${test_char} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function validate_char_test_cases () {
    char_is_present
    char_is_absent
}