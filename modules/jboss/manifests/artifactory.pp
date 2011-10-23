class jboss::artifatory(
  $artifatory_file      = $jboss::params::artifactory_file,
  $artifatory_file_path = $jboss::params::artifactory_file_path
) inherits jboss::params{


  $home = $::operatingsystem ? {
    default => '/home',
  }

  notify { "The value of artifactory_path is ${artifactory_path}.":}
  notify { "The value of artifactory_file is ${artifactory_file}.":}


  file { "/opt/jboss/":
    ensure => directory
  }

  file { "${artifactory_file_path}/${artifactory_file}":
    ensure => present,
    source => "puppet:///modules/jboss/files/${artifatory_file}",
  }
  

}
