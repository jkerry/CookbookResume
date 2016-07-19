#
# Cookbook Name:: Resume
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'apt::default'

package 'texlive' do
  action :install
  timeout 3600
end

package 'texlive-latex-extra' do
  action :install
  timeout 3600
end

build_user = 'vagrant'
build_group = 'vagrant'

user build_user do
  action :create
end

group build_group do
  action :modify
  members build_user
  append true
end

directory '/build/Resume' do
  recursive true
  owner build_user
  group build_group
  mode '0755'
end

template '/build/Resume/resume.cls' do
  source 'resume.cls.erb'
  owner build_user
  group build_group
  mode '0766'
end

template '/build/Resume/resume.tex' do
  source 'resume.tex.erb'
  owner build_user
  group build_group
  mode '0766'
end

directory '/build/Resume/images' do
  recursive true
  owner build_user
  group build_group
  mode '0755'
end

cookbook_file '/build/Resume/images/pic-chef-logo.png' do
  source 'pic-chef-logo.png'
  owner build_user
  group build_group
  mode '0755'
end

cookbook_file '/build/Resume/images/jenkins-logo.png' do
  source 'jenkins-logo.png'
  owner build_user
  group build_group
  mode '0755'
end

execute '/usr/bin/pdflatex -shell-escape resume.tex' do
  action :nothing
  cwd '/build/Resume'
  user build_user
  group build_group
  subscribes :run, 'template[/build/Resume/resume.tex]'
  subscribes :run, 'template[/build/Resume/resume.cls]'
end

directory '/home/vagrant/.ssh' do
  recursive true
  owner build_user
  group build_group
  mode '0755'
end

ssh_private_key = data_bag_item('ssh_keys', 'vagrant')
file '/home/vagrant/.ssh/id_rsa' do
  content ssh_private_key['id_rsa']
  sensitive true
  owner build_user
  group build_group
  mode '0700'
end

scp = 'scp -i ~/.ssh/id_rsa'
skip_validation = '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
files = "/build/Resume/resume.pdf #{node['resume']['delivery_target']}"
execute 'Deliver resume pdf' do
  action :nothing
  command "#{scp} #{skip_validation} #{files}"
  cwd '/build/Resume'
  user build_user
  group build_group
  subscribes :run, 'execute[/usr/bin/pdflatex -shell-escape resume.tex]'
  only_if { node['resume']['deliver_on_build'] }
end
