node /^build/ {
  class {'jenkins':
    require => [
                Class['jboss::java'],
                Class['iptables::apps'],
            ],
  }
  # Forward declaration to add the requirement for the java dependency
  class {'jboss::java': }
  class { 'iptables': }
  class { 'iptables::apps':
    require => Class['iptables'],
  }

  # XXX: disabling artifactory until it's fully fleshed out
  #class{'jboss::artifactory': }
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
