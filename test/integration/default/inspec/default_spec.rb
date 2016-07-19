#
# Cookbook Name:: Resume
# Spec:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.

describe package('texlive') do
  it { should be_installed }
end

describe package('texlive-latex-extra') do
  it { should be_installed }
end

describe group('vagrant') do
  it { should exist }
end

describe user('vagrant') do
  it { should exist }
  its('group') { should eq 'vagrant' }
end

describe file('/build/Resume') do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_readable.by('group') }
end

describe file('/build/Resume/resume.cls') do
  it { should be_file }
  its('md5sum') { should eq '483cbfa77a995214b6d63abf031893e3' }
end

describe file('/build/Resume/resume.tex') do
  it { should be_file }
  its('content') { should match(/.*name{John Kerry}.*/) }
end

describe file('/build/Resume/resume.pdf') do
  it { should be_file }
end

describe file('/build/Resume/images') do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_readable.by('group') }
end

describe file('/build/Resume/images/pic-chef-logo.png') do
  it { should_not be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_readable.by('group') }
  its('md5sum') { should eq '83aea75d94a3444a27ee9dcaf67aec1e' }
end

describe file('/build/Resume/images/jenkins-logo.png') do
  it { should_not be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_readable.by('group') }
  its('md5sum') { should eq '62c38a300ec97d401ea7fd1a4d948c18' }
end

describe file('/build/Resume/images/kitchen-logo.png') do
  it { should_not be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_readable.by('group') }
  its('md5sum') { should eq '82c166c23c49f5a7e5a8e2e7eeff217d' }
end

describe file('/home/vagrant/.ssh') do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_readable.by('group') }
end

describe file('/home/vagrant/.ssh/id_rsa') do
  it { should_not be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_executable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should_not be_executable.by('group') }
  it { should_not be_writable.by('group') }
  it { should_not be_readable.by('group') }
end
