class kubernetes::addons::dns (
  #TODO: use a params class
  $dns_replicas = 1,
  $dns_domain = 'cluster.local',
  $dns_server = '10.0.0.10'
) {
  include kubernetes::addons::namespace

  file{ '/etc/kubernetes/addons/dns':
    ensure  => directory,
    require => File['/etc/kubernetes/addons']
  }

  kubernetes::addons::addon{ 'dns-rc':
    file     => 'dns/skydns-rc.yaml',
    template => template("${module_name}/etc/kubernetes/addons/dns/skydns-rc.yaml.erb"),
    require  => File['/etc/kubernetes/addons/dns']
  }

  kubernetes::addons::addon{ 'dns-svc':
    file     => 'dns/skydns-svc.yaml',
    template => template("${module_name}/etc/kubernetes/addons/dns/skydns-svc.yaml.erb"),
    require  => File['/etc/kubernetes/addons/dns']
  }
}