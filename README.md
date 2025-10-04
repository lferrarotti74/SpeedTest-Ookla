# SpeedTest-Ookla

[![GitHub CI](https://github.com/lferrarotti74/SpeedTest-Ookla/workflows/Build%20release%20image/badge.svg)](https://github.com/lferrarotti74/SpeedTest-Ookla/actions/workflows/build.yml)
[![Release](https://img.shields.io/github/v/release/lferrarotti74/SpeedTest-Ookla)](https://github.com/lferrarotti74/SpeedTest-Ookla/releases)
[![Docker Hub](https://img.shields.io/docker/pulls/lferrarotti74/speedtest-ookla)](https://hub.docker.com/r/lferrarotti74/speedtest-ookla)
[![Docker Image Size](https://img.shields.io/docker/image-size/lferrarotti74/speedtest-ookla/latest)](https://hub.docker.com/r/lferrarotti74/speedtest-ookla)
[![GitHub](https://img.shields.io/github/license/lferrarotti74/SpeedTest-Ookla)](LICENSE)

<!-- SonarQube Badges -->
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=lferrarotti74_SpeedTest-Ookla&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=lferrarotti74_SpeedTest-Ookla)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=lferrarotti74_SpeedTest-Ookla&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=lferrarotti74_SpeedTest-Ookla)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=lferrarotti74_SpeedTest-Ookla&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=lferrarotti74_SpeedTest-Ookla)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=lferrarotti74_SpeedTest-Ookla&metric=reliability_rating)](https://sonarcloud.io/summary/new_code?id=lferrarotti74_SpeedTest-Ookla)

A Docker container for the [Ookla Speedtest CLI](https://www.speedtest.net/apps/cli), the official command-line interface for testing internet connection performance. This container provides an easy way to measure internet speed metrics like download, upload, latency and packet loss without needing to install the Speedtest CLI on your host system.

## What is Speedtest CLI?

Speedtest CLI brings the trusted technology and global server network behind Speedtest to the command line. Built for software developers, system administrators and computer enthusiasts alike, Speedtest CLI is the first official Linux-native Speedtest application backed by Ookla®.

With Speedtest CLI, you can easily:

- Measure internet connection performance metrics like download, upload, latency and packet loss natively without relying on a web browser
- Test the internet connection of your Linux desktop, a remote server or even lower-powered devices such as the Raspberry Pi® with the Speedtest Server Network™
- Set up automated scripts to collect connection performance data, including trends over time
- Output structured data ready for integration with visualization dashboards and observability platforms
- Use Speedtest in your programs by wrapping it in the programming language of your choice
- View test results via CSV, JSONL or JSON

## Quick Start

### Pull the Docker Image

```bash
docker pull lferrarotti74/speedtest-ookla:latest
```

### Run a Basic Speed Test

```bash
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest
```

## Usage Examples

### Basic Speed Test

Run a standard speed test:

```bash
# Basic speed test
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest

# Speed test with specific server ID
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --server-id=12345
```

### List Available Servers

```bash
# List nearby servers
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest -L
```

### Output Formats

```bash
# JSON output
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --format=json

# CSV output
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --format=csv

# JSONL output for logging
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --format=jsonl

# Pretty JSON output
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --format=json-pretty

# TSV output
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --format=tsv
```

### Advanced Options

```bash
# Verbose output
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest -v

# Multiple verbosity levels
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest -vv

# Specify precision
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --precision=4

# Use specific units
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --unit=Gbps

# Auto-scaled decimal bits
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest -a

# Show server selection details
docker run --rm lferrarotti74/speedtest-ookla:latest speedtest --selection-details
```

### Using with Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  speedtest:
    image: lferrarotti74/speedtest-ookla:latest
    command: ["speedtest", "--format=json"]
    
  # Scheduled speed test (requires cron or similar)
  speedtest-scheduled:
    image: lferrarotti74/speedtest-ookla:latest
    command: ["speedtest", "--format=csv"]
    volumes:
      - ./results:/results
```

### Automated Testing with Results Storage

```bash
# Save results to a file
docker run --rm -v $(pwd)/results:/results lferrarotti74/speedtest-ookla:latest speedtest --format=csv > results/speedtest-$(date +%Y%m%d-%H%M%S).csv

# Run periodic tests (example with cron)
# Add to crontab: */30 * * * * docker run --rm -v /path/to/results:/results lferrarotti74/speedtest-ookla:latest speedtest --format=json >> /path/to/results/speedtest.jsonl
```

## Available Command Options

The Speedtest CLI supports various options:

### Basic Options
- `-h, --help` - Print usage information
- `-V, --version` - Print version number
- `-L, --servers` - List nearest servers
- `-s, --server-id=#` - Specify a server from the server list using its id
- `-o, --host=ARG` - Specify a server using its host's fully qualified domain name

### Network Interface Options
- `-I, --interface=ARG` - Attempt to bind to the specified interface when connecting to servers
- `-i, --ip=ARG` - Attempt to bind to the specified IP address when connecting to servers

### Output Format Options
- `-f, --format=ARG` - Output format (see valid formats below)
- `-P, --precision=#` - Number of decimals to use (0-8, default=2)
- `--output-header` - Show output header for CSV and TSV formats

### Progress and Display Options
- `-p, --progress=yes|no` - Enable or disable progress bar (defaults to yes when interactive)
- `--progress-update-interval=#` - Progress update interval (100-1000 milliseconds)
- `--selection-details` - Show server selection details
- `-v` - Logging verbosity (specify multiple times for higher verbosity)

### Unit Options
- `-u, --unit[=ARG]` - Output unit for displaying speeds (only for human-readable format, default: Mbps)
- `-a` - Shortcut for `[-u auto-decimal-bits]`
- `-A` - Shortcut for `[-u auto-decimal-bytes]`
- `-b` - Shortcut for `[-u auto-binary-bits]`
- `-B` - Shortcut for `[-u auto-binary-bytes]`

### Security Options
- `--ca-certificate=ARG` - CA Certificate bundle path

### Legacy Options (Docker Container Specific)
- `--accept-license` - Accept license without prompt
- `--accept-gdpr` - Accept GDPR without prompt

### Valid Output Formats
- `human-readable` (default) - Human-friendly output
- `csv` - Comma-separated values
- `tsv` - Tab-separated values  
- `json` - JSON format
- `jsonl` - JSON Lines format
- `json-pretty` - Pretty-printed JSON

**Note**: Machine readable formats (csv, tsv, json, jsonl, json-pretty) use bytes as the unit of measure with max precision.

### Valid Units for `-u` Flag
**Decimal prefix, bits per second**: `bps`, `kbps`, `Mbps`, `Gbps`  
**Decimal prefix, bytes per second**: `B/s`, `kB/s`, `MB/s`, `GB/s`  
**Binary prefix, bits per second**: `kibps`, `Mibps`, `Gibps`  
**Binary prefix, bytes per second**: `kiB/s`, `MiB/s`, `GiB/s`  
**Auto-scaled prefix**: `auto-binary-bits`, `auto-binary-bytes`, `auto-decimal-bits`, `auto-decimal-bytes`

## Network Requirements

- Internet connection for testing
- Access to Ookla's Speedtest server network
- No special network configuration required (works through NAT/firewalls)

## Building from Source

To build the Docker image yourself:

```bash
git clone https://github.com/lferrarotti74/SpeedTest-Ookla.git
cd SpeedTest-Ookla
docker build -t speedtest-ookla .
```

## Documentation

- **[Contributing Guidelines](CONTRIBUTING.md)** - How to contribute to the project
- **[Code of Conduct](CODE_OF_CONDUCT.md)** - Community standards and behavior expectations
- **[Security Policy](SECURITY.md)** - How to report security vulnerabilities
- **[Changelog](CHANGELOG.md)** - Version history and release notes
- **[Maintainers](MAINTAINERS.md)** - Project governance and maintainer information
- **[Authors](AUTHORS.md)** - Contributors and acknowledgments

## Contributing

We welcome contributions from the community! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

- **Bug Reports**: Use GitHub issues with detailed information
- **Feature Requests**: Propose enhancements via GitHub issues
- **Code Contributions**: Fork, create feature branch, and submit PR
- **Documentation**: Help improve docs and examples

Please follow our [Code of Conduct](CODE_OF_CONDUCT.md) in all interactions.

## Support

For issues related to this Docker container, please open an issue on [GitHub](https://github.com/lferrarotti74/SpeedTest-Ookla/issues).

For Speedtest CLI support, please refer to [Ookla's support resources](https://support.ookla.com/).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Note**: This Docker container packages the official Ookla Speedtest CLI. The Speedtest CLI itself is proprietary software owned by Ookla and is subject to Ookla's terms of service and license agreements. By using this container, you agree to comply with Ookla's [Terms of Use](https://www.speedtest.net/about/terms) and [Privacy Policy](https://www.speedtest.net/about/privacy).

## Related Links

- [Official Speedtest CLI](https://www.speedtest.net/apps/cli)
- [Ookla Speedtest](https://www.speedtest.net/)
- [Speedtest CLI Documentation](https://www.speedtest.net/apps/cli)
- [Docker Hub Repository](https://hub.docker.com/r/lferrarotti74/speedtest-ookla)