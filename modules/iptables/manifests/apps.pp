# Class: iptables::apps
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
class iptables::apps {
  firewall { '083 jboss allow':
    dport       => '8080',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }
}
