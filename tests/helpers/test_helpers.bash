#!/bin/bash

# Test helper functions for SpeedTest-Ookla Docker container testing

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Docker image name for testing
TEST_IMAGE="speedtest-test:latest"

# Helper function to check if Docker image exists
docker_image_exists() {
    local image_name="$1"
    docker images --format "table {{.Repository}}:{{.Tag}}" | grep -q "^${image_name}$"
}

# Helper function to run speedtest container with command
run_speedtest_container() {
    local cmd="$1"
    local extra_args="${2:-}"
    
    docker run --rm ${extra_args} "${TEST_IMAGE}" ${cmd}
}

# Helper function to run speedtest container and capture output
run_speedtest_container_output() {
    local cmd="$1"
    local extra_args="${2:-}"
    
    docker run --rm ${extra_args} "${TEST_IMAGE}" ${cmd} 2>&1
}

# Helper function to validate JSON output
validate_json() {
    local json_string="$1"
    echo "${json_string}" | jq . > /dev/null 2>&1
}

# Helper function to check if output contains expected string
output_contains() {
    local output="$1"
    local expected="$2"
    echo "${output}" | grep -q "${expected}"
}

# Helper function to check if output matches pattern
output_matches_pattern() {
    local output="$1"
    local pattern="$2"
    echo "${output}" | grep -E -q "${pattern}"
}

# Helper function to get container exit code
get_container_exit_code() {
    local cmd="$1"
    local extra_args="${2:-}"
    
    docker run --rm ${extra_args} "${TEST_IMAGE}" ${cmd} > /dev/null 2>&1
    echo $?
}

# Helper function to check if speedtest binary exists in container
check_speedtest_binary() {
    run_speedtest_container "which speedtest" > /dev/null 2>&1
}

# Helper function to print test section header
print_test_header() {
    local header="$1"
    echo -e "${YELLOW}=== ${header} ===${NC}"
}

# Helper function to print success message
print_success() {
    local message="$1"
    echo -e "${GREEN}✓ ${message}${NC}"
}

# Helper function to print error message
print_error() {
    local message="$1"
    echo -e "${RED}✗ ${message}${NC}"
}

# Helper function to wait for container to be ready (if needed)
wait_for_container() {
    local timeout="${1:-10}"
    local count=0
    
    while [ $count -lt $timeout ]; do
        if check_speedtest_binary; then
            return 0
        fi
        sleep 1
        ((count++))
    done
    
    return 1
}

# Helper function to cleanup test artifacts
cleanup_test_artifacts() {
    # Remove any temporary files or containers if needed
    docker container prune -f > /dev/null 2>&1 || true
}