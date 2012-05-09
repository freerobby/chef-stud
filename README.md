# Description

Install and configure [stud](https://github.com/bumptech/stud), a scalable TLS unwrapping daemon

# Requirements

* Tested on Ubuntu Linux

* Uses the install\_from cookbook to build stud.

# Attributes

All attributes exist under the node[:stud]

* `[:version]` - The tagged version of stud to install from. Installing from HEAD is not currently supported.
* `[:user]` - The user to install and run stud under. Must have write permissions under /usr/local/share.

# Usage

All you need to do is include the [stud::default] recipe in your role