#!/usr/bin/env bats

# Load test helpers
load '../helpers/test_helpers'

setup() {
    print_test_header "Output Format Tests"
}

teardown() {
    cleanup_test_artifacts
}

@test "speedtest --format=json-pretty should produce valid JSON with server list" {
    run run_speedtest_container_output "-L --format=json-pretty"
    [ "$status" -eq 0 ]
    
    # Validate JSON structure
    run validate_json "$output"
    [ "$status" -eq 0 ]
    
    # Check for expected JSON fields in server listing
    [[ "$output" =~ "servers" ]]
    print_success "JSON-pretty format works correctly"
}

@test "speedtest --format=json should produce valid JSON with server list" {
    run run_speedtest_container_output "-L --format=json"
    [ "$status" -eq 0 ]
    
    # Validate JSON structure
    run validate_json "$output"
    [ "$status" -eq 0 ]
    
    # Check for expected JSON fields
    [[ "$output" =~ "servers" ]]
    print_success "JSON format works correctly"
}

@test "speedtest --format=csv should produce CSV output with server list" {
    run run_speedtest_container_output "-L --format=csv"
    [ "$status" -eq 0 ]
    
    # CSV should contain comma-separated values
    [[ "$output" =~ "," ]]
    print_success "CSV format works correctly"
}

@test "speedtest --format=tsv should produce TSV output with server list" {
    run run_speedtest_container_output "-L --format=tsv"
    [ "$status" -eq 0 ]
    
    # TSV should contain tab-separated values
    [[ "$output" =~ $'\t' ]]
    print_success "TSV format works correctly"
}

@test "Invalid format should return error" {
    run get_container_exit_code "-L --format=invalid"
    [ "$status" -ne 0 ]
    print_success "Invalid format options are properly rejected"
}

@test "Format option should work with short form" {
    run run_speedtest_container_output "-L -f json"
    [ "$status" -eq 0 ]
    
    # Validate JSON structure
    run validate_json "$output"
    [ "$status" -eq 0 ]
    print_success "Short form format option works correctly"
}

@test "JSON output should be parseable by jq" {
    run run_speedtest_container_output "-L --format=json"
    [ "$status" -eq 0 ]
    
    # Test if jq can parse and extract data
    echo "$output" | jq '.servers' > /dev/null 2>&1
    [ "$?" -eq 0 ]
    print_success "JSON output is parseable by jq"
}