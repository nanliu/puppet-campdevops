class jboss(
  $jboss_file = $jboss::params::jboss_file
) {


  $jboss_path = regsubst($jboss_file, '/\.zip/', '')

  $home = $::operatingsystem ? {
    default => '/home',
  }

  notify { "The value of jboss_path is ${jboss_path}.":}
  notify { "The value of jboss_file is ${jboss_file}.":}

  user { 'jboss':
    ensure => present,
    gid    => 'jboss',
  }

  group { 'jboss':
    ensure => present,
  }

  file { "${home}/jboss":
    ensure => directory,
    owner  => 'jboss',
    group  => 'jboss',
  }

  file { "/var/tmp/${jboss_file}":
    ensure => present,
    source => "puppet:///modules/jboss/${jboss_file}",
    before => Exec['unzip-jboss'],
  }

  package {'unzip':
    ensure => present,
  }

  exec { 'unzip-jboss':
    command => "/usr/bin/unzip ${jboss_file} -d /opt",
    creates => "/opt/${jboss_path}",
    require => Package['unzip'],
  }
}
