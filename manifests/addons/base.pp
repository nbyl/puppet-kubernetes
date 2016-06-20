class kubernetes::addons::base {
  include ::updater

  class { '::namespace':
    require => Class['::updater'],
  }
}
