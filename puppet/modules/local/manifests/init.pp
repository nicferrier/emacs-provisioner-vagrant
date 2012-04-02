class local {
    include local::myrepo

    file { "vc-clone-or-pull":
      source => "/vagrant/vc-clone-or-pull",
      path => "/home/vagrant/vc-clone-or-pull",
      mode => "0744",
      owner => "vagrant",
      group => "users",
    }

    exec { 'my_repo':
      require => File["vc-clone-or-pull"],
      command => "/home/vagrant/vc-clone-or-pull ${local::myrepo::my_repo_src} /home/vagrant/my_repo.git",
      path => "/bin:/usr/bin:",
      user => "vagrant",
      group => "users",
    }

    exec { 'emacsbuild':
      require => Exec['my_repo'],
      command => '/home/vagrant/emacs/bin/emacs -Q --script /home/vagrant/my_repo.git/build.el',
      path => '/usr/bin:/bin:/home/vagrant/emacs/bin',
      user => "vagrant",
      group => "users",
      logoutput => true,     
    }
}
