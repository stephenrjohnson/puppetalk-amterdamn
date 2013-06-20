class nagios
{
package { ['nagios3','nagios-nrpe-plugin','nagios-nrpe-server','nagios-plugins']:
	ensure => present,
}
httpauth { 'nagiosadmin':
  file      => '/etc/nagios3/htpasswd.users',
  password  => 'password',
  mechanism => basic,
  ensure    => present,
  require => Package['nagios3'],
}
file {'/etc/nagios3/htpasswd.users':
  mode      => 777,
  require => Package['nagios3'],
}
file {'/etc/nagios3/nagios.cfg':
 ensure    => file,
 source    => 'puppet:///modules/nagios/nagios.cfg',
 mode      => '0644',
 owner     => root,
 group     => root,
 notify    => Service['nagios3'],
 require => Package['nagios3'],
}
file {'/etc/nagios3/puppetsconf.d':
 ensure  => directory,
 mode    => '0644',
 owner   => root,
 group   => root,
 recurse => true,
 purge   => true,
 notify  => Service['nagios3'],
 require => Package['nagios3'],
}

service{'nagios3':
  ensure    => running,
  enable    => true,
  require => Package['nagios3'],
}
File <<| tag == 'nagioshosts' |>>
File <<| tag == 'nagiosservices' |>>

}
