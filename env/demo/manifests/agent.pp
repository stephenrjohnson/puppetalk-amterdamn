node default {

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

  ###### puppet

  class { 'puppet::agent':
    puppet_server             => 'master.puppetlabs.vm',
  }

  host{'master.puppetlabs.vm':
    ensure => present,
    ip => '172.16.0.2',
  }
}
