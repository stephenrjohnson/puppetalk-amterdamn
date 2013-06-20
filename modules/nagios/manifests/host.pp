class nagios::host
(
  $use = 'generic-host',
  $host_name = $::fqdn,
  $alias = $::fqdn,
  $address = $::fqdn
)
{ 
 @@file{"/etc/nagios3/puppetsconf.d/${::fqdn}_host.cfg":
   ensure => file,
   mode => 0644,
   owner => root,
   group => root,
   content => template('nagios/host.cfg.erb'),
   tag => 'nagioshosts',
   notify => Service['nagios3'],
 }
}
