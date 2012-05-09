#
# Cookbook Name:: stud
# Recipe:: default
#
# Copyright 2012, Robby Grossman
#
# MIT Licensed, or any other license you want
#

package "openssl"
package "libssl-dev"
package "libev-dev"

install_from_release('stud') do
  release_url   "https://github.com/bumptech/stud/tarball/#{node[:stud][:version]}"
  release_ext   "tar.gz"
  user          node[:stud][:user]
  version       node[:stud][:version]
  action        [:build_with_make]
end
