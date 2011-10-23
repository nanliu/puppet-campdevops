class iptables::puppet {
  firewall { '081 puppetdashboard allow':
    dport       => '3000',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '082 puppet allow':
    dport       => '8140',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }

  firewall { '090 mcollective allow':
    dport       => '61613',
    proto       => 'tcp',
    destination => '0.0.0.0/0',
    source      => '0.0.0.0/0',
  }
}
