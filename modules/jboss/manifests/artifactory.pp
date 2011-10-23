class artifatory_file(
  $artifatory_file      = $artifatory_file::params::artifatory_file_file,
  $artifatory_file_path = $artifatory_file::params::artifatory_file_file_path
) inherits artifatory::params {


  $artifatory_file_path = regsubst($artifatory_file_file, '\.zip', '')

  $home = $::operatingsystem ? {
    default => '/home',
  }

  notify { "The value of artifatory_file_path is ${artifatory_file_path}.":}
  notify { "The value of artifatory_file_file is ${artifatory_file_file}.":}

  user { 'artifatory_file':
    ensure => present,
    gid    => 'artifatory_file',
  }

  group { 'artifatory_file':
    ensure => present,
  }

  file { "${home}/artifatory_file":
    ensure => directory,
    owner  => 'artifatory_file',
    group  => 'artifatory_file',
  }

  file { "${artifactory_file_path}/${artifatory_file_file}":
    ensure => present,
    source => "puppet:///modules/artifatory_file/files/${artifatory_file}"
  }

  package {'unzip':
    ensure => present,
  }

  file { "${artifatory_file_path}/${artifatory_file}":
    ensure => present,
    source => "puppet:///modules/artifatory/${artifatory_file}",
  }
  
  exec { 'install-artifatory':
  	
  }

}
