define kubernetes::addons::addon (
  $file,
  $template = undef
) {
  include kubernetes::addons::updater

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