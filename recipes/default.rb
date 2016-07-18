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

execute '/usr/bin/pdflatex -shell-escape resume.tex' do
  action :nothing
  cwd '/build/Resume'
  user build_user
  group build_group
  subscribes :run, 'template[/build/Resume/resume.tex]'
  subscribes :run, 'template[/build/Resume/resume.cls]'
end
