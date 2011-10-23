# Class: iptables::utils
#
#   Push utils file to puppet lib since it's not part of pluginsync.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class iptables::utils {
  file { '/opt/puppet/lib/ruby/site_ruby/1.8/puppet/util/firewall.rb':
    owner  => '0',
    group  => '0',
    source => 'puppet:///modules/iptables/firewall.rb',
  }

  file { '/opt/puppet/lib/ruby/site_ruby/1.8/puppet/util/ipcidr.rb':
    owner  => '0',
    group  => '0',
    source => 'puppet:///modules/iptables/ipcidr.rb',
  }
}
