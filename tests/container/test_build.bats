#!/usr/bin/env bats

# Load test helpers
load '../helpers/test_helpers'

setup() {
    print_test_header "Container Build Tests"
}

teardown() {
    cleanup_test_artifacts
}

@test "Docker image should exist after build" {
    run docker_image_exists "${TEST_IMAGE}"
    [ "$status" -eq 0 ]
    print_success "Docker image exists"
}

@test "Container should start without errors" {
    run run_speedtest_container "--help"
    [ "$status" -eq 0 ]
    print_success "Container starts successfully"
}

@test "Speedtest binary should be installed and accessible" {
    run check_speedtest_binary
    [ "$status" -eq 0 ]
    print_success "Speedtest binary is accessible"
}

@test "Container should run as non-root user" {
    run run_speedtest_container_output "whoami"
    [ "$status" -eq 0 ]
    [[ "$output" == "speedtest" ]]
    print_success "Container runs as speedtest user"
}

@test "Container should have correct working directory" {
    run run_speedtest_container_output "pwd"
    [ "$status" -eq 0 ]
    [[ "$output" == "/home/speedtest" ]]
    print_success "Working directory is correct"
}

@test "Container should have speedtest configuration directory" {
    run run_speedtest_container "test -d /home/speedtest/.config/ookla"
    [ "$status" -eq 0 ]
    print_success "Configuration directory exists"
}

@test "Container should have aliases script" {
    run run_speedtest_container "test -f /home/speedtest/aliases.sh"
    [ "$status" -eq 0 ]
    print_success "Aliases script exists"
}

@test "Container should have speedtest-cli.json configuration" {
    run run_speedtest_container "test -f /home/speedtest/.config/ookla/speedtest-cli.json"
    [ "$status" -eq 0 ]
    print_success "Speedtest CLI configuration exists"
}

@test "Container should have proper file permissions" {
    run run_speedtest_container_output "ls -la /usr/bin/speedtest"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-rwxr-xr-x" ]]
    print_success "Speedtest binary has correct permissions"
}

@test "Container should be based on Alpine Linux" {
    run run_speedtest_container_output "cat /etc/os-release"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Alpine Linux" ]]
    print_success "Container is based on Alpine Linux"
}