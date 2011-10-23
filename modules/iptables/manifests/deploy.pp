# Class: iptables::deploy
#
#   class description goes here.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class iptables::deploy {
  firewall { '085 deploy allow':
    dport       => '4440',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }
}
