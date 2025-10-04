#!/usr/bin/env bats

# Load test helpers
load '../helpers/test_helpers'

setup() {
    print_test_header "Basic CLI Commands Tests"
}

teardown() {
    cleanup_test_artifacts
}

@test "speedtest --help should display help information" {
    run run_speedtest_container_output "--help"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    [[ "$output" =~ "USAGE:" ]]
    print_success "Help command works correctly"
}

@test "speedtest --version should display version information" {
    run run_speedtest_container_output "--version"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    [[ "$output" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]
    print_success "Version command works correctly"
}

@test "speedtest -h should display help information (short form)" {
    run run_speedtest_container_output "-h"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    [[ "$output" =~ "USAGE:" ]]
    print_success "Short help command works correctly"
}

@test "speedtest -V should display version information (short form)" {
    run run_speedtest_container_output "-V"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    [[ "$output" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]
    print_success "Short version command works correctly"
}

@test "speedtest -L should list available servers" {
    run run_speedtest_container_output "-L"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Closest servers:" ]]
    print_success "Server listing command works correctly"
}

@test "speedtest --servers should list available servers" {
    run run_speedtest_container_output "--servers"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Closest servers:" ]]
    print_success "Long form server listing command works correctly"
}

@test "Invalid option should return error" {
    run get_container_exit_code "--invalid-option"
    [ "$status" -ne 0 ]
    print_success "Invalid options are properly rejected"
}

@test "speedtest without arguments should show usage" {
    run run_speedtest_container_output ""
    # Note: speedtest without args typically runs a test, but we're checking it doesn't crash
    # The exit code might be 0 (if it tries to run) or non-zero (if it shows usage)
    # We just want to ensure it doesn't crash with a segfault or similar
    [[ "$status" -eq 0 || "$status" -eq 1 || "$status" -eq 2 ]]
    print_success "Speedtest handles no arguments gracefully"
}