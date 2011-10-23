class jboss::artifatory(
  $artifatory_file      = $artifactory::params::artifactory_file,
  $artifatory_file_path = $artifactory::params::artifactory_file_path
) inherits artifatory::params {


  $artifactory_path = regsubst($artifactory_file, '\.zip', '')

  $home = $::operatingsystem ? {
    default => '/home',
  }

  notify { "The value of artifactory_path is ${artifactory_path}.":}
  notify { "The value of artifactory_file is ${artifactory_file}.":}

  user { 'artifactory':
    ensure => present,
    gid    => 'artifactory',
  }

  group { 'artifactory':
    ensure => present,
  }

  file { "${home}/artifactory":
    ensure => directory,
    owner  => 'artifactory',
    group  => 'artifactory',
  }

  file { "${artifactory_file_path}/${artifactory_file}":
    ensure => present,
    source => "puppet:///modules/jboss/files/${artifatory_file}"
  }


}
