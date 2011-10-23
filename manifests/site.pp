node /^build/ {
  class {'jenkins': }
}

node /^app/ {
}

node /^deploy/ {
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

