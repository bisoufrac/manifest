
# configure hostname

# configure network interfaces
# use adrien-network
network_config { 'lo':
  ensure => 'present',
  family => 'inet',
  method => 'loopback',
  onboot => 'true',
}

network_config { 'eth0':
  ensure  => 'present',
  family  => 'inet',
  method  => 'dhcp',
  onboot  => 'true',
  hotplug => 'true',
}

network_config { 'wlan0':
  ensure    => 'present',
  family    => 'inet',
  method    => 'static',
  ipaddress => '192.168.30.1',
  netmask   => '255.255.255.0',
  onboot    => 'true',
}

# configure iptables
# use puppetlabs-firewall



# configure sysctl
# use thias-sysctl
sysctl { 'net.ipv4.ip_forward': value => '1' }

# configure ntp
# use puppetlabs-ntp (master version to have
# interfaces support
class { '::ntp':
    servers    => [ 'ntp.unice.fr', 
                    '0.fr.pool.ntp.org', 
                    '1.fr.pool.ntp.org' ],
    restrict   => [ '127.0.0.1', '192.168.30.0/24' ],
    interfaces => [ '127.0.0.1', '192.168.30.1' ],
}


# configure apt

# configure hostapd
#class { '::hostapd':
#  ssid           => 'privacy',
#  interface      => 'wlan0',
#  driver         => 'rtl871xdrv',
#  hw_mode        => 'g',
#  wpa            => '2',
#  wpa_passphrase => 'test',
#  wpa_key_mgmt   => 'WPA-PSK',

#}


# configure isc-dhcp-server
# use theforeman-dhcp
# doesn't work as i want. doesn't work whithout pxe. 
# doesn't implement options like ntpserver, ....

class { 'dhcp':
  dnsdomain   => [ 'mybox.lan', '30.168.192.in-addr.arpa' ],
  nameservers => [ '192.168.30.1' ],
  ntpservers  => [ '192.168.30.1' ],
  interfaces  => [ 'wlan0' ],
}

dhcp::pool { 'mybox.lan':
  network => '192.168.30.0',
  mask    => '255.255.255.0',
  range   => [ '192.168.30.10', '192.168.30.20' ],
  gateway => '192.168.30.1',
}


# configure apache


