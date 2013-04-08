node default {
  $hostname = 'master.puppetlabs.vm'

  package { 'vim':
    ensure  => installed,
  }

  ### Add the puppetlabs repo
  apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      => 'main',
    key        => '4BD6EC30',
    key_server => 'keyserver.ubuntu.com',
  }

  Exec["apt_update"] -> Package <| |>

  ####### puppetdb
  class { 'puppetdb':
  }

  ###### puppet
  class { 'puppet::master':
    storeconfigs     => true,
  }

  class { 'puppet::agent':
    puppet_server             => $hostname,
  }

file {'/etc/puppet/manifests':
    ensure              => link,
    target          => '/demo',
    require     => Package['puppetmaster'],
    force   => true,
  }

  file {'/etc/puppet/modules':
    ensure              => link,
    target          => '/tmp/vagrant-puppet/modules-0',
    require     => Package['puppetmaster'],
    force   => true,
  }

  host{'agent.puppetlabs.vm':
    ensure => present,
    ip     => '172.16.0.3',
  }
}
