class jboss(
  $jboss_file      = $jboss::params::jboss_file,
  $stage_path      = $jboss::params::stage_path,
  $install_path    = $jboss::params::install_path,
  $mysql_file      = $jboss::params::mysql_file
) inherits jboss::params {


  $jboss_path = regsubst($jboss_file, '\.zip', '')
  $mysql_path = regsubst($mysql_file, '\.zip', '')

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

  file { "${stage_path}/${jboss_file}":
    ensure => present,
    source => "puppet:///modules/jboss/${jboss_file}",
    before => Exec['unzip-jboss'],
  }

  file { "${stage_path}/${mysql_file}":
    ensure => present,
    source => "puppet:///modules/jboss/${mysql_file}",
    before => Exec['unzip-mysql'],
  }

  package {'unzip':
    ensure => present,
  }

  exec { 'unzip-jboss':
    command => "/usr/bin/unzip ${stage_path}/${jboss_file} -d ${install_path}",
    creates => "${install_path}/${jboss_path}",
    require => Package['unzip'],
  }

  exec { 'unzip-mysql':
    command => "/usr/bin/unzip ${stage_path}/${mysql_file} -d ${install_path}",
    creates => "${install_path}/${mysql_path}",
    require => Package['unzip'],
  }

  file { "${install_path}/${jboss_path}/server/default/lib/${mysql_path}-bin.jar":
    ensure  => present,
    source  => "${install_path}/${mysql_path}/${mysql_path}-bin.jar",
    require => Exec['unzip-mysql'],
    notify  => Service['jboss'],
  }

  file { "${install_path}/${jboss_path}/bin/run.sh":
    ensure  => present,
    require => Exec['unzip-jboss'],
    mode    => '0755',
  }

  file { "${install_path}/${jboss_path}/bin/shutdown.sh":
    ensure  => present,
    require => Exec['unzip-jboss'],
    mode    => '0755',
  }

  service { 'jboss':
    ensure    => running,
    hasstatus => false,
    pattern   => $jboss_path,
    start     => "${install_path}/${jboss_path}/bin/run.sh &",
    stop      => "${install_path}/${jboss_path}/bin/shutdown.sh",
    restart   => "${install_path}/${jboss_path}/bin/shutdown.sh -S && /bin/sleep 10 && ${install_path}/${jboss_path}/bin/run.sh &",
    require   => [Exec['unzip-jboss'], File["${install_path}/${jboss_path}/bin/shutdown.sh"], File["${install_path}/${jboss_path}/bin/run.sh"]],
  }
}
