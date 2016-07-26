#
# Cookbook Name:: Resume
# Recipe:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.
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
