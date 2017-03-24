# # encoding: utf-8

# Inspec test for recipe chef_docker::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'docker-present' do
  title 'Docker enabled and running'
  describe service('docker') do
  	it { should be_enabled }
  	it { should be_running }
  end
end

describe bash('docker inspect -f \{\{.State.Running\}\} test_jenkins_image') do
  its('stderr') { should eq '' }
  its('stdout') { should match 'true' }
end

describe bash('docker port test_jenkins_image 8080/tcp') do
  its('stderr') { should eq '' }
  its('stdout') { should match '0.0.0.0:8080' }
end

describe bash('curl http://127.0.0.1:8080/job/HelloWorld/lastBuild/consoleText') do
  its('stdout') { should match 'Finished: SUCCESS' }
  its('stdout') { should match 'Hello World' }
end