#
# Cookbook Name:: stud
# Recipe:: default
#
# Copyright 2012, Robby Grossman
#
# MIT Licensed, or any other license you want
#

include_recipe "build-essential"

package "openssl"
package "libssl-dev"
package "libev-dev"
package "git"

raise "node[:stud][:pemfile] must be a path to a pemfile containing your certificate and private key!" if node[:stud][:pemfile_path].nil?

git "#{node[:stud][:install_prefix_root]}/share/stud" do
  repository "git://github.com/bumptech/stud.git"
  reference "0.3"
  action :sync
end

execute "build-stud" do
  user node[:stud][:user]
  cwd "#{node[:stud][:install_prefix_root]}/share/stud"
  command "make && make install"
  action :run
end

# Link the binary to the one we built
link "#{node[:stud][:install_prefix_root]}/bin/stud" do
  to "#{node[:stud][:install_prefix_root]}/share/stud/stud"
  action :create
end

run_flags = []

run_flags << "--tls" if node[:stud][:options][:tls] && !node[:stud][:options][:ssl]
run_flags << "--ssl" if node[:stud][:options][:ssl]
run_flags << "-c #{node[:stud][:options][:cipher_suite]}" if node[:stud][:options][:cipher_suite]
run_flags << "-e #{node[:stud][:options][:engine]}" if node[:stud][:options][:engine]

run_flags << "-b #{node[:stud][:options][:backend_host]},#{node[:stud][:options][:backend_port]}" if node[:stud][:options][:backend_host] && node[:stud][:options][:backend_port]
run_flags << "-f #{node[:stud][:options][:frontend_host]},#{node[:stud][:options][:frontend_port]}" if node[:stud][:options][:frontend_host] && node[:stud][:options][:frontend_port]

run_flags << "-n #{node[:stud][:options][:workers]}" if node[:stud][:options][:workers]
run_flags << "-B #{node[:stud][:options][:backlog]}" if node[:stud][:options][:backlog]
run_flags << "-k #{node[:stud][:options][:keepalive_secs]}" if node[:stud][:options][:keepalive_secs]

run_flags << "-r #{node[:stud][:options][:chroot_path]}" if node[:stud][:options][:chroot_path]
run_flags << "-u #{node[:stud][:options][:user]}" if node[:stud][:options][:user]

run_flags << "-q" if node[:stud][:options][:quiet]
run_flags << "-s" if node[:stud][:options][:send_to_syslog]

run_flags << "--write-ip" if node[:stud][:options][:write_ip]
run_flags << "--write-proxy" if node[:stud][:options][:write_proxy]

# Kill existing processes
execute "stop-stud" do
  user node[:stud][:user]
  command "killall stud || echo 'Warning: no processes to kill'"
  action :run
end

# Start the process
execute "start-stud" do
  user node[:stud][:user]
  command "stud #{run_flags.join(" ")} #{node[:stud][:pemfile_path]} &"
  action :run
end
