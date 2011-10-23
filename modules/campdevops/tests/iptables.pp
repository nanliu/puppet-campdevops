# Chain INPUT (policy ACCEPT)
# num  target     prot opt source               destination
# 1    RH-Firewall-1-INPUT  all  --  0.0.0.0/0            0.0.0.0/0
#
# Chain FORWARD (policy ACCEPT)
# num  target     prot opt source               destination
# 1    RH-Firewall-1-INPUT  all  --  0.0.0.0/0            0.0.0.0/0
#
# Chain OUTPUT (policy ACCEPT)
# num  target     prot opt source               destination
#
# Chain RH-Firewall-1-INPUT (2 references)
# num  target     prot opt source               destination
# 1    ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0
# 2    ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0           icmp type 255
# 3    ACCEPT     esp  --  0.0.0.0/0            0.0.0.0/0
# 4    ACCEPT     ah   --  0.0.0.0/0            0.0.0.0/0
# 5    ACCEPT     udp  --  0.0.0.0/0            224.0.0.251         udp dpt:5353
# 6    ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0           udp dpt:631
# 7    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0           tcp dpt:631
# 8    ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED
# 9    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0           state NEW tcp dpt:22
# 10   REJECT     all  --  0.0.0.0/0            0.0.0.0/0           reject-with icmp-host-prohibited

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

firewall { '007 allow related, established':
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

firewall { '080 http allow':
  dport       => '80',
  proto       => 'tcp',
  destination => '0.0.0.0/0',
  source      => '0.0.0.0/0',
}

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

resources { 'firewall':
  purge => false,
}
