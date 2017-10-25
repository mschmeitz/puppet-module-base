class base inherits base::params {

    user { 'deploy':
        
        ensure      => present,
        uid         => 5001,
        password    => '$1$KaAD3dBV$4KYLNla7uat9Zo8P0qsXz.',
        home        => '/home/deploy',
        managehome  => true,
    }
    
    package { [ 'tree', 'wget', 'git', 'unzip' ,'ntp' ] :}

    user { 'dojo':
        ensure =>  absent,
    }
    
    file { '/etc/motd':
      ensure    => present,
      owner     => 'root',
      group     => 'root',
      mode      => '0644',
      content   => "
      
      This server is the property of XYZ Inc.
      
      SYSTEM INFO
      -----------
      
      HOSTNAME   :  ${::fqdn}
      IPADDRESS  :  ${::ipaddress}
      CPU CORES  :  ${::processors['count']}
      OS FAMILY  :  ${::os['distro']['description']}
      
      ",
    }
    
    service { $::base::ntp_service :
      ensure     => running,
      name       => $::base::ntp_service,
      enable     => true,
    }

}