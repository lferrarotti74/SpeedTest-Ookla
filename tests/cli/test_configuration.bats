#!/usr/bin/env bats

# Load test helpers
load '../helpers/test_helpers'

setup() {
    print_test_header "Configuration Tests"
}

teardown() {
    cleanup_test_artifacts
}

@test "speedtest should accept license with --accept-license" {
    run run_speedtest_container_output "--accept-license --help"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    print_success "License acceptance option works correctly"
}

@test "speedtest should accept GDPR with --accept-gdpr" {
    run run_speedtest_container_output "--accept-gdpr --help"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    print_success "GDPR acceptance option works correctly"
}

@test "speedtest should work with both license and GDPR acceptance" {
    run run_speedtest_container_output "--accept-license --accept-gdpr --help"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Speedtest by Ookla" ]]
    print_success "Combined license and GDPR acceptance works correctly"
}

@test "Configuration file should exist in container" {
    run run_shell_container "test -f /home/speedtest/.config/ookla/speedtest-cli.json"
    [ "$status" -eq 0 ]
    print_success "Configuration file exists"
}

@test "Configuration file should be valid JSON" {
    run run_shell_container_output "cat /home/speedtest/.config/ookla/speedtest-cli.json"
    [ "$status" -eq 0 ]
    
    # Validate JSON structure
    run validate_json "$output"
    [ "$status" -eq 0 ]
    print_success "Configuration file is valid JSON"
}

@test "Configuration directory should have correct permissions" {
    run run_shell_container_output "ls -ld /home/speedtest/.config/ookla"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "drwx" ]]
    print_success "Configuration directory has correct permissions"
}

@test "Configuration file should have correct ownership" {
    run run_shell_container_output "ls -l /home/speedtest/.config/ookla/speedtest-cli.json"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "1 root     root" ]]
    print_success "Configuration file has correct ownership"
}

@test "Aliases script should be executable" {
    run run_shell_container_output "ls -l /etc/profile.d/aliases.sh"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-rwx" ]]
    print_success "Aliases script is executable"
}