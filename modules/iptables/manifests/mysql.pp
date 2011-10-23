# Class: iptables::mysql
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
class iptables::mysql inherits iptables() {
  firewall { '084 mysql allow':
    dport       => '3306',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }
}
