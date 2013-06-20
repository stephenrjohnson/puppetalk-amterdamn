define nagios::service
(
  $use,
  $host_name = $::fqdn,
  $desc,
  $command,
)
{ 
 @@file{"/etc/nagios3/puppetsconf.d/${::fqdn}_$desc.cfg":
   ensure => file,
   mode => 0644,
   owner => root,
   group => root,
   content => template('nagios/service.cfg.erb'),
   tag => 'nagiosservices',
   notify => Service['nagios3'],
 }
}
