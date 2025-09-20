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
docker run --rm lferrarotti74/speedtest-ookla:latest
```

## Usage Examples

### Basic Speed Test

Run a standard speed test:

```bash
# Basic speed test
docker run --rm lferrarotti74/speedtest-ookla:latest

# Speed test with specific server ID
docker run --rm lferrarotti74/speedtest-ookla:latest --server-id=12345
```

### List Available Servers

```bash
# List nearby servers
docker run --rm lferrarotti74/speedtest-ookla:latest --servers

# List servers in a specific country
docker run --rm lferrarotti74/speedtest-ookla:latest --servers --country=US
```

### Output Formats

```bash
# JSON output
docker run --rm lferrarotti74/speedtest-ookla:latest --format=json

# CSV output
docker run --rm lferrarotti74/speedtest-ookla:latest --format=csv

# JSONL output for logging
docker run --rm lferrarotti74/speedtest-ookla:latest --format=jsonl
```

### Advanced Options

```bash
# Test only download speed
docker run --rm lferrarotti74/speedtest-ookla:latest --no-upload

# Test only upload speed
docker run --rm lferrarotti74/speedtest-ookla:latest --no-download

# Accept license and GDPR automatically
docker run --rm lferrarotti74/speedtest-ookla:latest --accept-license --accept-gdpr

# Verbose output
docker run --rm lferrarotti74/speedtest-ookla:latest --verbose
```

### Using with Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  speedtest:
    image: lferrarotti74/speedtest-ookla:latest
    command: ["--format=json", "--accept-license", "--accept-gdpr"]
    
  # Scheduled speed test (requires cron or similar)
  speedtest-scheduled:
    image: lferrarotti74/speedtest-ookla:latest
    command: ["--format=csv", "--accept-license", "--accept-gdpr"]
    volumes:
      - ./results:/results
```

### Automated Testing with Results Storage

```bash
# Save results to a file
docker run --rm -v $(pwd)/results:/results lferrarotti74/speedtest-ookla:latest --format=csv --accept-license --accept-gdpr > results/speedtest-$(date +%Y%m%d-%H%M%S).csv

# Run periodic tests (example with cron)
# Add to crontab: */30 * * * * docker run --rm -v /path/to/results:/results lferrarotti74/speedtest-ookla:latest --format=json --accept-license --accept-gdpr >> /path/to/results/speedtest.jsonl
```

## Available Command Options

The Speedtest CLI supports various options:

- `--servers` - List available servers
- `--server-id=<id>` - Use specific server
- `--format=<format>` - Output format (human-readable, csv, tsv, json, jsonl)
- `--precision=<digits>` - Number of decimal places (0-8, default 2)
- `--unit=<unit>` - Output unit for speeds (bps, kbps, Mbps, Gbps)
- `--no-download` - Skip download test
- `--no-upload` - Skip upload test
- `--accept-license` - Accept license without prompt
- `--accept-gdpr` - Accept GDPR without prompt
- `--verbose` - Verbose output
- `--help` - Show help information

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