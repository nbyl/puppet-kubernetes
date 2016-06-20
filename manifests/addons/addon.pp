class kubernetes::addons::addon_updater {
  file{ '/etc/kubernetes/addons':
    ensure => directory
  }

  file{ '/etc/kubernetes/kube-addon-update.sh':
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/kube-addon-update.sh"),
    mode    => 755
  }

  file{ '/etc/kubernetes/kube-addons.sh':
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/kube-addons.sh"),
    mode    => 755
  }

  file{ '/usr/lib/systemd/system/kube-addons.service':
    ensure  => present,
    content => template("${module_name}/systemd/kube-addons.service.erb"),
  }

  service { 'kube-addons':
    ensure  => running,
    enable  => true,
    require => File['/usr/lib/systemd/system/kube-addons.service']
  }
}

define kubernetes::addons::addon (
  $file,
  $template = undef
) {
  include kubernetes::addons::addon_updater

  if(!$template) {
    $content = template("${module_name}/etc/kubernetes/addons/${file}.erb")
  } else {
    $content = $template
  }

  file{ "/etc/kubernetes/addons/${file}":
    ensure  => present,
    content => $content
  }
}