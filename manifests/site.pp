node /^build/ {
  class {'jenkins':
    require => Class['jboss::java'],
  }
  class{'jboss::artifactory': }
  # Forward declaration to add the requirement for the java dependency
  class {'jboss::java': }
}

node /^app/ {
  class { 'iptables': }
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

