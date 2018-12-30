# Change Log
All notable changes to the project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0] - 2018-12-31
- Dropping support for Ruby 2.1
- Dropping support for Puppet 3
- Reversed `toughen::services` parameters - they're no longer double negatives. You'll need to flip your booleans!
- Adding `inet_protocols = ipv4` to postfix so it starts when ipv6 is disabled.
- Made warning banner smaller
- Beaker tests not working yet

## [0.7.0] - 2017-07-04
- Adding securetty settings
- Fixing some CI stuff

## [0.6.0] - 2017-05-12
- Tried (and failed) to add an SSSD class. Needs work on a box with SSSD configured.
- Enabling the audisp syslog plugin for auditd
- Disabling `zeroconf`
- **New class** - `modprobe`. Unifies blacklisted modules from `filesystem` and `network`.
- Extra network parameters for sysctl
- Initializing aide
- Updating yum.conf with gpg checks etc
- Adding reasonably accurate policy for scanning with oscap tools
- Moved defined types to a folder

## [0.5.2] - 2017-05-11
- Fixing filesystem mount parameters
- Splitting kernel parameters so that network ones are in network.pp
- Fixing some typos
- Making travis builds work properly again

## [0.5.1] - 2017-05-05
- Logic was wrong on rpcbind fact

## [0.5.0] - 2017-05-05
- Adds permission controls to /etc/shadow and similar
- Fixes #1 by detecting rpcbind properly

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
