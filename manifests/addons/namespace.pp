class kubernetes::addons::namespace {
  kubernetes::addons::addon{ 'namespace':
    template => 'namespace.yml'
  }
}