# Class: iptables
#
#   class description goes here.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class iptables{

  class { 'iptables::utils':
    before => Class['iptables'],
  }

  firewall { '001 input allow all':
    proto       => 'all',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '002 icmp allow all':
    proto       => 'icmp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '003 esp allow all':
    proto       => 'esp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '004 ah allow all':
    proto       => 'ah',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '005 ipp udp allow all':
    proto       => 'udp',
    dport       => '631',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '006 ipp tcp allow all':
    proto       => 'tcp',
    dport       => '631',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '007 allow related established':
    proto       => 'all',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
    state       => ['RELATED', 'ESTABLISHED'],
  }

  firewall { '022 ssh allow':
    dport       => '22',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
    state       => 'NEW',
  }

  resources { 'firewall':
    purge => true,
  }
}
