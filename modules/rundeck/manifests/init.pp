# Class: rundeck
#
# This module installs RunDeck
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
class rundeck{
  file { 'latest.rpm':
    path    => '/tmp/latest.rpm',
    source  => 'puppet:///modules/rundeck/latest.rpm',
  }
  exec { 'rundeck_repo':
    command => 'rpm -i /tmp/latest.rpm',
    path    => '/bin:/usr/bin',
    creates => '/etc/yum.repos.d/rundeck.repo',
    require => file['latest.rpm'],
  }
  package { 'rundeck':
    ensure  => present,
    require => exec['rundeck_repo'],
  }
  service { 'rundeckd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => package['rundeck'],
  }

	group { 'anthony':
	  ensure  => present,
	  require => Package['rundeck'],
	}
  user { 'anthony':
	  ensure     => present,
    groups     => 'rundeck',
    membership => 'minimum',
  }
  file { '/home/anthony':
    ensure => directory,
		mode   => '0700',
    owner  => 'anthony',
    group  => 'anthony',
  }
  file { '/home/anthony/.ssh':
    ensure => directory,
		mode   => '0700',
    owner  => 'anthony',
    group  => 'anthony',
  }
	ssh_authorized_key { 'anthony':
	  ensure => present,
	  key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAz6KdBTLyr7085G5ey0qaUk7NLBE93cMQoHIQlzUfq+I3MJeC6TGAhj17xkmkc3m2aWtGQjF48uSn0YtjdB3/jxfej1mVNK+nWNwihcUpVmaj0daiuoEigbvPiLSQlrt/eRvktL1jaRzxaBevfv46Jr9kIE+DwyBuT3l6iNvaeSSSuGZgjVAM7vwq8p2vp1f01jIQFHbDNIMPl2CnkAsH7kYUx40mvNtW32FO+CBhPaQfOOF/T3vZe9qTvCoUsf2+WVuUcfFS7PbLSuPFiVMx5mg4X2VcfefsuXdcP7w62PlJMN5ylN+CtKyb7vj25nlQmtq1TH3TJeulEfMundOWew',
	  name   => 'rundeck',
	  type   => 'ssh-rsa',
	  user   => 'anthony',
	}
}
