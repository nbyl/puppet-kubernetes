# == Class: kubernetes::addons::dns
#
# [*dns_replicas*]
#   Whether you want the apiserver daemon to start up
#   Defaults to running
#
class kubernetes::addons::dns (
  $dns_replicas = $kubernetes::master::params::dns_replicas,
  $dns_domain   = $kubernetes::master::params::dns_domain,
  $dns_server   = $kubernetes::master::params::dns_server
) {
  include ::base

  file{ '/etc/kubernetes/addons/dns':
    ensure  => directory,
    require => File['/etc/kubernetes/addons'],
  }

  file{ '/etc/kubernetes/addons/dns/skydns-rc.yaml':
    content => template("${module_name}/etc/kubernetes/addons/dns/skydns-rc.yaml.erb"),
    require => File['/etc/kubernetes/addons/dns'],
  }

  file{ '/etc/kubernetes/addons/dns/skydns-svc.yaml':
    content => template("${module_name}/etc/kubernetes/addons/dns/skydns-svc.yaml.erb"),
    require => File['/etc/kubernetes/addons/dns'],
  }
}
