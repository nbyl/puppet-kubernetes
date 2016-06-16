class kubernetes::addons::addon_directory {
  file{ '/etc/kubernetes/addons':
    ensure => directory
  }
}

define kubernetes::addons::addon (
  $file,
  $template = undef
) {
  include kubernetes::addons::addon_directory

  if(!$template) {
    $content = template("${module_name}/etc/kubernetes/addons/${file}.erb")
  } else {
    $content = $template
  }

  file{ "/etc/kubernetes/addons/${file}":
    ensure  => present,
    content => $content
  }

  exec { "kubernetes_apply_${name}":
    command     => "/bin/kubectl apply -f /etc/kubernetes/addons/${file}",
    refreshonly => true,
    subscribe   => File["/etc/kubernetes/addons/${file}"]
  }
}