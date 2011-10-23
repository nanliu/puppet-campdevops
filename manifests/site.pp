# global deploy mcollectivepe

class { 'mcollectivepe':
}

node /^build1/ {
  class { 'iptables': }
  class { 'iptables::apps':
    require => Class['iptables'],
  }

  class {'jboss::java': }
  class {'jenkins':
    require => Class['jboss::java', 'iptables::apps'],
  }
}

node /^build2/ {
  class { 'iptables': }
  class { 'iptables::apps':
    require => Class['iptables'],
  }

  class {'jboss': }
  class {'jboss::java': }

  class { 'jboss::artifactory':
    require => Class['jboss::java', 'jboss', 'iptables::apps'],
  }
}

node /^app/ {
  class { 'iptables': }
  class { 'iptables::apps':
    require => Class['iptables'],
  }
  class { 'jboss':
    require => Class['jboss::java'],
  }
  class { 'jboss::java': }
}

node /^deploy/ {
  class { 'iptables': }
  class { 'iptables::deploy':
    require => Class['iptables'],
  }
  class { 'jboss::java': }
  class { 'rundeck': }
}

node /^source/ {
  class { 'iptables': }
  class { 'iptables::puppet':
    require => Class['iptables'],
  }
  class { 'svn': }
}

node /^db/ {
  class { 'iptables': }
  class { 'iptables::mysql':
    require => Class['iptables'],
  }

  # Fixing a bug with mysql module.
  file { '/etc/mysql':
    ensure => directory,
  }

  $mysql_config = { bind_address      => '127.0.0.1',
                    root_password     => 'campdevops_r0cks',
                    etc_root_password => true }
  class { 'mysql::server':
    config_hash => $mysql_config,
  }
  mysql::db { 'dukesbank':
    user     => 'dukesbank',
    password => 'dukesbank',
    host     => $::hostname,
    grant    => ['all'],
  }
}
