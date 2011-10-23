class { 'jboss': 
  require => Class['jboss::java'],
}
include jboss::java

