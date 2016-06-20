class kubernetes::addons::namespace {
  kubernetes::addons::addon{ 'namespace':
    file => 'namespace.yaml'
  }
}