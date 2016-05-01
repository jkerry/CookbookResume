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
  it { should be_file }
  its('md5sum') { should eq '8ec1e15ab4c53340bc92863668c7be49' }
end

describe file('/build/Resume/resume.tex') do
  it { should be_file }
  its('md5sum') { should eq '2293e65e32c61ee95927f827d9c1cefd' }
end
