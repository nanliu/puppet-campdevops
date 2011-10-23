# Class: svn::iptabls
#
#   svn iptables
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class svn::iptables {
  firewall { '080 http allow':
    dport       => '80',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }
}
