node /^build/ {
  # Disabled temporarily, puppet-jenkins borks on RHEL
  #class {'jenkins': }
  class{'jboss::artifactory': }
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

