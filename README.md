# Description

Install and configure [stud](https://github.com/bumptech/stud), a scalable TLS unwrapping daemon

# Requirements

* Tested on Ubuntu Linux

* Uses the install\_from cookbook to build stud.

# Attributes

All attributes exist under the node[:stud]

* `[:version]` - The tagged version of stud to install from. Installing from HEAD is not currently supported.
* `[:user]` - The user to install and run stud under. Must have write permissions under /usr/local/share.
* `[:install_prefix_root]` - The prefix root under which stud is installed. Stud will be installed to <this folder>/share/stud.
* `[:pemfile_path]` = The path to the chained pemfile (must include private key and certificate)

The following attributes are used to pass options to the stud command line interface. They default to the stud defaults/recommendations.

* `[:options][:tls]` - Use TLSv1. Ignored if `[:options][:ssl]` is true.
* `[:options][:ssl]` - Use SSLv3 (implies no TLSv1)
* `[:options][:cipher_suite]` - set allowed ciphers (default is OpenSSL defaults)
* `[:options][:engine]` - set OpenSSL engine
* `[:options][:backend_host]` - backend host to connect to (default 127.0.0.1)
* `[:options][:backend_port]` - backend port to connect to (default 8000)
* `[:options][:frontend_host]` - frontend host to connect to (default *)
* `[:options][:frontend_port]` - frontend port to connect to (default 8443)
* `[:options][:workers]` - number of worker processes (default 1)
* `[:options][:backlog]` - listen backlog size (default 100)
* `[:options][:keepalive_secs]` - change the default keepalive on client socket
* `[:options][:chroot_path]`
* `[:options][:user]` - gid/uid to set after binding the sockiet
* `[:options][:quiet]` - emit only error messages
* `[:options][:send_to_syslog]` - send log messages to syslog
* `[:options][:write_ip]` - write 1 octet with the IP family allowed by the IP address in 4 (IPv4) or 16 (IPv6) octets little-endian
* `[:options][:write_proxy]` - write HaProxy's PROXY (IPv4 or IPv6) protocol line before actual data

# Usage

All you need to do is include the [stud::default] recipe in your role, and configure any attributes whose defaults you wish to override.

Note that this recipe honors the defaults/recommendations as set forth by the stud authors. I recommend the following changes for a typical SSL environment.

* `[:options][:ssl]` - true
* `[:options][:workers]` - 2 (or however many workers you have - nobody runs single core machines these days)
* `[:options][:write_proxy]` - true (iff you use haproxy 1.5+)
