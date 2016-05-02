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

template "/build/Resume/resume.cls" do
  source "resume.cls.erb"
end

template "/build/Resume/resume.tex" do
  source "resume.tex.erb"
end

script 'compile_resume' do
  interpreter "bash"
  action :nothing
  cwd "/build/Resume/"
  code <<-EOH
    pdflatex resume.tex
  EOH
  subscribes :run, 'template[/build/Resume/resume.tex]'
  subscribes :run, 'template[/build/Resume/resume.cls]'
end
