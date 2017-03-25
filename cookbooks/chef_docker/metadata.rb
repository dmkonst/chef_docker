name 'chef_docker'
maintainer 'DK'
maintainer_email 'warqueq@gmail.com'
license 'all_rights'
description 'Installs/Configures chef_docker'
long_description 'Installs/Configures chef_docker'
version '0.1.0'

issues_url 'https://github.com/dmkonst/chef_docker/issues' if respond_to?(:issues_url)

source_url 'https://github.com/dmkonst/chef_docker' if respond_to?(:source_url)

depends 'docker', '~> 2.0'
