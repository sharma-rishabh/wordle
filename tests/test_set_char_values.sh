function all_correct () {
    local test_orignal_word=world
    local test_guessed_word=world
    local expected_output="00000"
    local input="Orignal word : ${test_orignal_word} , Guessed word : ${test_guessed_word}"
    local function_name=set_char_values
    local description="It should output all zeros if the guess is correct."
    local actual_output=$( set_char_values ${test_orignal_word} ${test_guessed_word} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}


function all_incorrect () {
    local test_orignal_word=world
    local test_guessed_word=abcef
    local expected_output="22222"
    local input="Orignal word : ${test_orignal_word} , Guessed word : ${test_guessed_word}"
    local function_name=set_char_values
    local description="It should output all twos if all guessed characters are incorrect."
    local actual_output=$( set_char_values ${test_orignal_word} ${test_guessed_word} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function all_incorrect_position () {
    local test_orignal_word=world
    local test_guessed_word=dlwor
    local expected_output="11111"
    local input="Orignal word : ${test_orignal_word} , Guessed word : ${test_guessed_word}"
    local function_name=set_char_values
    local description="It should output all ones if all guessed chars are right but not in right position."
    local actual_output=$( set_char_values ${test_orignal_word} ${test_guessed_word} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}


function some_correct () {
    local test_orignal_word=world
    local test_guessed_word=words
    local expected_output="00012"
    local input="Orignal word : ${test_orignal_word} , Guessed word : ${test_guessed_word}"
    local function_name=set_char_values
    local description="It should set values to characters based on their presence and position in the orignal word."
    local actual_output=$( set_char_values ${test_orignal_word} ${test_guessed_word} )
    verify_expectation "$actual_output" "$expected_output" "$description" "$input" "$function_name"
}

function set_char_values_test_cases () {
    all_correct
    all_incorrect
    all_incorrect_position
    some_correct
}