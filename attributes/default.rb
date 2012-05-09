default[:stud][:version] = "0.3"
default[:stud][:user] = "root"
default[:stud][:install_prefix_root] = "/usr/local"
default[:stud][:pemfile_path] = nil

# Encryption options
default[:stud][:options][:tls] = true
default[:stud][:options][:ssl] = false
default[:stud][:options][:cipher_suite] = nil
default[:stud][:options][:engine] = nil

# Socket options
default[:stud][:options][:backend_host] = "127.0.0.1"
default[:stud][:options][:backend_port] = "8000"
default[:stud][:options][:frontend_host] = "*"
default[:stud][:options][:frontend_port] = "8443"

# Performance options
default[:stud][:options][:workers] = 1
default[:stud][:options][:backlog] = 100
default[:stud][:options][:keepalive_secs] = nil

# Security options
default[:stud][:options][:chroot_path] = nil
default[:stud][:options][:user] = nil

# Logging options
default[:stud][:options][:quiet] = false
default[:stud][:options][:send_to_syslog] = false

# Special options
default[:stud][:options][:write_ip] = false
default[:stud][:options][:write_proxy] = false # Set this to true if you're using haproxy
