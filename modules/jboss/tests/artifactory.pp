class { 'jboss::artifactory': 
  require => Class['jboss::java'],
}
include jboss::java