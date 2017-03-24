require 'spec_helper'

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end


describe docker_image('dmkonst/fun_with_jenkins') do
  it { should exist }
end

describe docker_container('test_jenkins_image') do
  it { should be_running }
  its (['Config.ExposedPorts']) {should include '8080/tcp'}
end

describe command('curl http://127.0.0.1:8080/job/HelloWorld/lastBuild/consoleText') do
  its(:stdout) { should match 'Finished: SUCCESS' }
  its(:stdout) { should match 'Hello World' }
  its(:exit_status) { should eq 0 }
end