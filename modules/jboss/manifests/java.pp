class jboss::java {
  package { 'java':
    name   => 'java-1.6.0-openjdk-devel',
    ensure => present,
  }
}
