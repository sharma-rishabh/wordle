#! /bin/bash

#---------------------Global Variable---------------------
GREEN_BOLD="\033[1;32m"
NORMAL="\033[0;97m"
WHITE="\033[2;97m"
RED_BOLD="\033[1;31m"

PASS="✔"
FAIL="✗"
NUM_OF_TEST=0
FAILING_TESTS=()
IFS=$'\n'

source lib/library.sh

source tests/test_validate_word.sh
source tests/test_validate_char.sh
source tests/test_validate_position.sh
source tests/test_set_char_values.sh


function verify_expectation() {
	local actual="$1"
	local expected="$2"
	local description="$3"
	local inputs="$4"
	local function_name=$5
	NUM_OF_TEST=$(( $NUM_OF_TEST + 1 ))
	local test_result=$FAIL
	if [[ "$actual" == "$expected" ]]
	then
		test_result=$PASS
		echo -e "\t${GREEN_BOLD}${test_result}   ${WHITE}${description} ${NORMAL}"
		return 0
	fi
	echo -e "\t${RED_BOLD}${test_result}   ${description} ${NORMAL}"
	local results="actual:${actual} , expected :${expected}"
	local position=${#FAILING_TESTS[@]}
	FAILING_TESTS[$position]="$function_name | $description | $results | $inputs "
}

function all_test_cases() {
	echo -e "\n\n  ${NORMAL}validate_word"
	validate_word_test_cases
	echo -e "\n\n  ${NORMAL}validate_char"
    validate_char_test_cases
	echo -e "\n\n  ${NORMAL}validate_position"
    validate_position_test_cases
	echo -e "\n\n  ${NORMAL}set_char_values"
    set_char_values_test_cases
}


function display_failed_test() {
	echo -e "\n\nFailing Test cases\n"
	for i in ${FAILING_TESTS[@]}
	do
		function_name=$( echo $i | cut -f1 -d"|" );
		des=$( echo $i | cut -f2 -d"|" )
		res=$( echo $i | cut -f3 -d"|" )
		inputs=$( echo $i | cut -f4 -d"|" )
		echo -e "   $function_name \n\t Description : $des \n\t Results : $res \n\t Inputs : $inputs\n"
	done
}

function display_report() {
	all_test_cases
	if [[ ${#FAILING_TESTS[@]} -gt 0 ]]
	then
		display_failed_test
	fi
	echo -e "\n\n\t\t\t\t Failing Test : ${#FAILING_TESTS[@]}/${NUM_OF_TEST}\n\n"

}

display_report
