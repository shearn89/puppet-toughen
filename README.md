# toughen

[![Build Status](https://travis-ci.org/shearn89/puppet-toughen.svg?branch=develop)](https://travis-ci.org/shearn89/puppet-toughen) [![Code Climate](https://codeclimate.com/github/shearn89/puppet-toughen/badges/gpa.svg)](https://codeclimate.com/github/shearn89/puppet-toughen) [![Test Coverage](https://codeclimate.com/github/shearn89/puppet-toughen/badges/coverage.svg)](https://codeclimate.com/github/shearn89/puppet-toughen/coverage)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with toughen](#setup)
    * [What toughen affects](#what-toughen-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with toughen](#beginning-with-toughen)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
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

### What toughen affects **OPTIONAL**

A range from everything to nothing - it's server hardening. If you're unaware
what that involves I **strongly recommend** you read the guides.

### Beginning with toughen

TODO
The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

TODO
This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

TODO
Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

TODO
This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

TODO
Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

