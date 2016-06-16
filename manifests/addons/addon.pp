class kubernetes::addons::addon_directory {
  file{ '/etc/kubernetes/addons':
    ensure => directory
  }
}

define kubernetes::addons::addon (
  $template
) {
  include kubernetes::addons::addon_directory

  file{ "/etc/kubernetes/addons/${template}":
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/addons/${template}.erb")
  }

  exec { "kubernetes_apply_${name}":
    command     => "/bin/kubectl apply -f /etc/kubernetes/addons/${template}",
    refreshonly => true,
    subscribe   => File["/etc/kubernetes/addons/${template}"]
  }
}