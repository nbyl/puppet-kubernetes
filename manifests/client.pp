# Class: kubernetes::client
#
# This module manages kubernetes-client package.
# It only populates the /etc/kubernetes/config file: it empties all variables.
#
# Parameters:
#
# [*ensure*]
#   Set package version to be installed or use 'installed'/'latest'
#   Defaults to installed
#
class kubernetes::client ($ensure = 'present',) {
  # /etc/kubernetes/config is managed by both master and node rpms
  # so we take care of it here
  validate_string($ensure)

  package { 'kubernetes-client': ensure => $ensure, } ->
  file { '/etc/kubernetes/': ensure => 'directory', } ->
  file { '/etc/kubernetes/config':
    ensure  => 'file',
    force   => true,
    content => template("${module_name}/etc/kubernetes/config.erb"),
  }
}
