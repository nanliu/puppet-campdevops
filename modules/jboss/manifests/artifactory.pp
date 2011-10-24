class jboss::artifactory(
  $artifactory_file      = $jboss::params::artifactory_file,
  $artifactory_file_path = $jboss::params::artifactory_file_path
) inherits jboss{


  file { "${install_path}/${jboss_path}/server/default/deploy/${artifactory_file}":
    ensure  => present,
    source  => "puppet:///modules/jboss/${artifactory_file}",
    require => Exec['unzip-jboss'],
  }
}
