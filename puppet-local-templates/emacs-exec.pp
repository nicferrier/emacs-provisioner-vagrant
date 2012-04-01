class local {
    include puppetvcs
    include local::myrepo

    exec { 'emacsbuild':
      require => Vcsrepo['/home/vagrant/myrepo.git'],
      command => '/home/vagrant/emacs/bin/emacs -Q --script /home/vagrant/myrepo.git/build.el',
      path => '/usr/bin:/bin:/home/vagrant/emacs/bin',
    }
}
