# Change Log
All notable changes to the project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.4.0] - 2017-05-04
- Adds cron config
- Fixes some noisy service calls

## [0.3.0] - 2017-05-04
- Adds SSH configuration
- Adds legacy services lock down
- Adds regular services lock down, with params to control e.g. http install.

## [0.2.0] - 2017-05-03
- Adds in a custom fact that finds binaries with the setuid flag, and tracks them under auditd.
- 100% STIG compliance for Auditd, the 'Systme Accounting with auditd' section.

## [0.1.2] - 2017-05-03
- Forgot to bump the metadata.json version to match the tag. Doh!

## [0.1.1] - 2017-05-03
- Tweaks to auditing class to meet STIG compliance standards with oscap scanner

## [0.1.0] - 2017-05-03
- Tag for initial usage

## [0.0.0] - 2016-06-16
### Added
- Initial bare commit
