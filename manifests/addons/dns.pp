class kubernetes::addons::dns (
  #TODO: use a params class
  $dns_replicas = 1,
  $dns_domain = 'cluster.local',
  $dns_server = '10.0.0.10'
) {
  include kubernetes::addons::base

  file{ '/etc/kubernetes/addons/dns':
    ensure  => directory,
    require => File['/etc/kubernetes/addons']
  }

  file{ '/etc/kubernetes/addons/dns/skydns-rc.yaml':
    content => template("${module_name}/etc/kubernetes/addons/dns/skydns-rc.yaml.erb"),
    require => File['/etc/kubernetes/addons/dns']
  }

  file{ '/etc/kubernetes/addons/dns/skydns-svc.yaml':
    content => template("${module_name}/etc/kubernetes/addons/dns/skydns-svc.yaml.erb"),
    require => File['/etc/kubernetes/addons/dns']
  }
}