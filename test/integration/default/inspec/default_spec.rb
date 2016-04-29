#
# Cookbook Name:: Resume
# Spec:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.

describe package('texlive') do
  it { should be_installed }
end
