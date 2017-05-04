# toughen

[![Build Status](https://travis-ci.org/shearn89/puppet-toughen.svg?branch=develop)](https://travis-ci.org/shearn89/puppet-toughen) [![Test Coverage](https://codeclimate.com/github/shearn89/puppet-toughen/badges/coverage.svg)](https://codeclimate.com/github/shearn89/puppet-toughen/coverage)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with toughen](#setup)
    * [What toughen affects](#what-toughen-affects)
    * [Beginning with toughen](#beginning-with-toughen)
1. [Usage - A quick how-to](#usage)
1. [Reference - Parameters, classes, types, etc.](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is a puppet module that applies various hardening controls as detailed in 
the documents referenced in `guides.txt`.

The aim of me writing my own module is to lay out the controls in a manner that
I feel is readable and easy to understand, whilst also providing flexibility to
the user so that they can add exceptions where necessary.

First priority for development will be CentOS 7, followed by RHEL7. Then the 
version 6 of both those, followed by Ubuntu and Debian. Other Linux OS's will
follow in good time.

## Setup

### What toughen affects 

A range from everything to nothing - it's server hardening. If you're unaware
what that involves I **strongly recommend** you read the guides.

### Beginning with toughen

At it's most basic, simply `include toughen`. However, this will apply the 
defaults with no consideration for any specific requirments. Good as a starting
point if you're building from scratch, not so good if you're hardening an 
existing server. For that you'll want to apply specific sections of the module.

## Usage

For more fine-grained usage, wrap sections into a `profile`:

    class profile::security {
        include toughen::aide
        include toughen::auditing
        include toughen::banners
        include toughen::boot
        include toughen::cron
        include toughen::filesystem
        ## Skip firewall, managed elsewhere.
        # include toughen::firewall
        include toughen::init
        include toughen::legacy_services
        include toughen::mandatory_access
        include toughen::network
        include toughen::pam
        include toughen::perms_owners
        include toughen::process
        include toughen::rsyslog
        include toughen::services
        include toughen::shadow
        include toughen::ssh
        include toughen::sudo
        ## Skip updates, managed elsewhere
        include toughen::updates
        include toughen::user_env
    }

You can also pass in parameters directly:

    class profile::security {

        class { 'toughen::ssh':
            $port => 2222,
            $allow_users => ['shearna', 'vagrant'],
        }

    }

And many other things. The full list of parameters is long and distinguished...

## Reference

TODO

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

So far, supported only on Puppet 3.8 and CentOS/RedHat 7.

Still to come:

* CentOS/RedHat 6
* Ubuntu 16.04.x LTS
* Amazon Linux?

Also:

* Scan results with well-known compliance scanners (Nessus, Nexpose)

At some point it would be nice to use some of the iterators in Puppet 4, given
RedHat doesn't use Puppet 4 yet, it's a ways off.

## Development

Please feel free to contribute via GitHub with a pull request. If you're 
adding classes, please add unit tests (take a look in `spec/classes/` for 
examples). You can get set up with:

    $> bundle install
    $> bundle exec rake

...which will lint, validate, and run the spec tests. Please ensure these tests
still pass when you have made changes!

You can also view the compliance score against the STIG 'RHEL7 upstream' 
profile. On CentOS 7:

    $> sudo yum install -y openscap-scanner scap-security-guide
    $> sudo oscap xccdf eval \
        --profile xccdf_org.ssgproject.content_profile_stig-rhel7-server-upstream \
        --results report.xml \
        --report  report.html \
        /usr/share/xml/scap/ssg/content/ssg-centos7-ds.xml

...and then open up report.html in a browser. Note that this module aims for
compliance with CIS standards, not STIG, so there is some discrepancy.

