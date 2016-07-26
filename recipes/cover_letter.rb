#
# Cookbook Name:: Resume
# Recipe:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.
include_recipe 'Resume::default'

build_user = 'vagrant'
build_group = 'vagrant'

directory '/build/CoverLetter/images' do
  recursive true
  owner build_user
  group build_group
  mode '0755'
end

cookbook_file '/build/CoverLetter/ModerncvClassic.zip' do
  source 'ModerncvClassic.zip'
  owner build_user
  group build_group
  mode '0755'
end

cookbook_file '/build/CoverLetter/images/jkerry.jpg' do
  source 'jkerry.jpg'
  owner build_user
  group build_group
  mode '0755'
end

zipfile '/build/CoverLetter/ModerncvClassic.zip' do
  action :nothing
  into '/build/CoverLetter'
  subscribes :extract, 'cookbook_file[/build/CoverLetter/ModerncvClassic.zip]', :immediate
end

template '/build/CoverLetter/cover_letter.tex' do
  source 'cover_letter.tex.erb'
  owner build_user
  group build_group
  mode '0766'
end

execute '/usr/bin/pdflatex cover_letter.tex' do
  action :nothing
  cwd '/build/CoverLetter'
  user build_user
  group build_group
  subscribes :run, 'zipfile[/build/CoverLetter/ModerncvClassic.zip]'
  subscribes :run, 'template[/build/CoverLetter/cover_letter.tex]'
end

scp = 'scp -i ~/.ssh/id_rsa'
skip_validation = '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
files = "/build/CoverLetter/cover_letter.pdf #{node['resume']['delivery_target']['cover_letter']}"
execute 'Deliver resume pdf' do
  action :nothing
  command "#{scp} #{skip_validation} #{files}"
  cwd '/build/CoverLetter'
  user build_user
  group build_group
  subscribes :run, 'execute[/usr/bin/pdflatex cover_letter.tex]'
  only_if { node['resume']['deliver_on_build'] }
end
