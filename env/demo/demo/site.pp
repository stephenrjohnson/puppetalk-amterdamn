node 'master.puppetlabs.vm'
{
 include nagios

 include nagios::host
 nagios::service{'httpcheck': 
   use => generic-service, 
   desc => 'Http', 
   command => 'check_http',
 }
}

node 'agent.puppetlabs.vm'
{
}
