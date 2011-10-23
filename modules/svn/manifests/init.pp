# Class: svn
#
# This module manages svn
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class svn {
  package { 'httpd':
    ensure => present,
  }

  package { 'mod_dav_svn':
    ensure  => present,
    require => Package['httpd'],
  }

  package { 'svn':
    ensure => present,
  }

  file { 'subversion.conf':
    path    => '/etc/httpd/conf.d/subversion.conf',
    owner   => 'apache',
    group   => 'apache',
    source  => 'puppet:///modules/svn/subversion.conf',
    require => Package['httpd','mod_dav_svn'],
  }

  file { '/var/www/svn':
    ensure => directory,
    require => Package['httpd'],
  }

  exec { 'create_dukesbank':
    command => 'svnadmin create dukesbank',
    cwd     => '/var/www/svn',
    path    => '/bin:/usr/bin',
    creates => '/var/www/svn/dukesbank',
    require => [ File['/var/www/svn'], Package['svn'] ],
  }

  file { '/var/www/svn/dukesbank':
    owner   => 'apache',
    group   => 'apache',
    recurse => true,
    require => Exec['create_dukesbank'],
  }

  service { 'httpd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [Package['mod_dav_svn'], File['subversion.conf']],
  }
}
