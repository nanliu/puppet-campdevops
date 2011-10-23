class jboss(
  $jboss_file      = $jboss::params::jboss_file,
  $jboss_file_path = $jboss::params::jboss_file_path
) inherits jboss::params {


  $jboss_path = regsubst($jboss_file, '\.zip', '')

  $home = $::operatingsystem ? {
    default => '/home',
  }

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

  file { "${jboss_file_path}/${jboss_file}":
    ensure => present,
    source => "puppet:///modules/jboss/${jboss_file}",
    before => Exec['unzip-jboss'],
  }

  package {'unzip':
    ensure => present,
  }

  exec { 'unzip-jboss':
    command => "/usr/bin/unzip ${jboss_file_path}/${jboss_file} -d /opt",
    creates => "/opt/${jboss_path}",
    require => Package['unzip'],
  }

  file { "/opt/${jboss_path}/bin/run.sh":
    ensure  => present,
    require => Exec['unzip-jboss'],
    mode    => '0755',
  }

  file { "/opt/${jboss_path}/bin/shutdown.sh":
    ensure  => present,
    require => Exec['unzip-jboss'],
    mode    => '0755',
  }

  service { 'jboss':
    ensure    => running,
    hasstatus => false,
    pattern   => $jboss_path,
    start     => "/opt/${jboss_path}/bin/run.sh &",
    stop      => "/opt/${jboss_path}/bin/shutdown.sh",
    require   => [Exec['unzip-jboss'], File["/opt/${jboss_path}/bin/shutdown.sh"], File["/opt/${jboss_path}/bin/run.sh"]],
  }
}
