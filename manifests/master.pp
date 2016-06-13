# == Class: kubernetes::master
#
# Module to install an up-to-date version of kubernetes from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the kubernetes-master package.
#   Defaults to present
#
class kubernetes::master ($ensure = 'present',) {
  validate_string($ensure)

  include ::kubernetes::client

  # this should ensure also that all files from /etc/kubernetes are managed after package install
  package { 'kubernetes-master': ensure => $ensure, } -> File['/etc/kubernetes/']
}
