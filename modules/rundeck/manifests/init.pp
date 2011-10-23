# Class: rundeck
#
# This module installs RunDeck
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class rundeck{
  file { 'latest.rpm':
    path    => '/tmp/latest.rpm',
    source  => 'puppet:///modules/rundeck/latest.rpm',
  }
  exec { 'rundeck_repo':
    command => 'rpm -i /tmp/latest.rpm',
    path    => '/bin:/usr/bin',
    creates => '/etc/yum.repos.d/rundeck.repo',
    require => file['latest.rpm'],
  }
  package { 'rundeck':
    ensure  => present,
    require => exec['rundeck_repo'],
  }
  service { 'rundeckd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => package['rundeck'],
  }
  user { 'anthony':
    name       => 'anthony',
    groups     => 'rundeck',
    membership => 'minimum',
  }
}
