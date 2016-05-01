#
# Cookbook Name:: Resume
# Spec:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.

describe package('texlive') do
  it { should be_installed }
end

describe file('/build/Resume') do
  it { should be_directory}
end

describe file('/build/Resume/res.cls') do
  it { should be_file}
end
