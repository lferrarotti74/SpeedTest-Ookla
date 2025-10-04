# Changelog

All notable changes to the SpeedTest-Ookla project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project documentation structure
- Comprehensive contribution guidelines
- Maintainer governance documentation
- Author attribution system

### Changed
- Updated project documentation to follow community standards

### Deprecated

### Removed

### Fixed

### Security

## [v1.2.0] - 2025-01-01

### Added
- Docker image for Ookla Speedtest CLI
- Multi-architecture support (amd64, arm64, armv7)
- Automated CI/CD pipeline with GitHub Actions
- Docker Scout security scanning
- SonarQube code quality analysis
- Dependabot dependency management
- MIT License with Ookla attribution

### Documentation
- README with comprehensive usage instructions
- Docker Hub integration
- Build and deployment workflows
- Speedtest CLI command examples and options

---

## Release Notes Guidelines

### Version Format
- **vX.Y.Z** (e.g., v1.2.0)
- Semantic versioning for Docker images
- Optional date-based versioning for development releases

### Change Categories
- **Added**: New features
- **Changed**: Changes in existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security improvements
- **Documentation**: Documentation updates

### Entry Format
- Use present tense ("Add feature" not "Added feature")
- Reference issues/PRs when applicable: `- Fix memory leak (#123)`
- Credit contributors: `- Add ARM support (@contributor)`

### Release Process
1. Update CHANGELOG.md with new version
2. Update version in relevant files
3. Create GitHub release with changelog excerpt
4. Tag release following semver

---

## Contributors

Thanks to all contributors who help improve this project:

- **Luca Ferrarotti** (@lferrarotti74) - Project Creator & Maintainer

*Contributors are automatically added when they make their first contribution.*

---

**Note**: Dates use YYYY-MM-DD format. Unreleased changes are tracked at the top.