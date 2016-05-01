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

directory "/build/Resume" do
  recursive true
end

remote_file "/build/Resume/res.cls" do
  source "http://www.rpi.edu/dept/arc/training/latex/resumes/res.cls"
end
