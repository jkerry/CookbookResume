#
# Cookbook Name:: Resume
# Spec:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.

describe package('texlive') do
  it { should be_installed }
end

describe file('/build/Resume') do
  it { should be_directory }
end

describe file('/build/Resume/resume.cls') do
  it { should be_file }
  its('md5sum') { should eq '483cbfa77a995214b6d63abf031893e3' }
end

describe file('/build/Resume/resume.tex') do
  it { should be_file }
  its('md5sum') { should eq 'dc581b0f70f84f4af7a155d4701e59c6' }
end

describe file('/build/Resume/resume.pdf') do
  it { should be_file }
  its('md5sum') { should eq '73621f1306bb9d0100e3ba72afd6c8d6' }
end
