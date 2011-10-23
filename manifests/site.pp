node /^build/ {
  class {'jenkins': }
}

node /^app/ {
  class {'jboss':
    require => Class['jboss::java'],
  }
  class {'jboss::java': }
}

node /^deploy/ {
  class {'jboss::java': }
}

node /^source/ {
  class { 'iptables': }
  class { 'iptables::puppet': }
  class { 'svn': }
}

node /^db/ {
  class { 'mysql::server':
    root_password => 'campdevops_r0cks',
  }
}

