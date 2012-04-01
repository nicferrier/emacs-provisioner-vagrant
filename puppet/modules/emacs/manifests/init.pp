class emacs {
      include depends

      exec { "checkout":
        require => Package["git"],
        command => "git clone /vagrant/emacs.git /home/vagrant/emacs.git",
        path => "/usr/bin:/bin",
        creates => "/home/vagrant/emacs.git/configure.in",
      }

      file { "emacsdir":
        path => "/home/vagrant/emacs",
        ensure => "directory",
        owner => "vagrant",
        group => "users"
      }

      exec { "autogen.sh":
        require => [File["emacsdir"], Exec["checkout"]],
        command => "sh autogen.sh",
        creates => "/home/vagrant/emacs.git/configure",
        path => "/bin:/usr/bin",
        cwd => "/home/vagrant/emacs.git",
      }

      exec { "install":
         require => [File["emacsdir"], Exec["autogen.sh"]],
         timeout => 0,
         command => "sh configure --prefix=/home/vagrant/emacs \
--without-sound \
--without-sync-input \
--without-xpm         \
--without-jpeg          \
--without-tiff          \
--without-gif           \
--without-png           \
--without-rsvg          \
--without-xml2          \
--without-imagemagick   \
--without-xft           \
--without-libotf       \
--without-m17n-flt      \
--without-toolkit-scroll-bars \
--without-xaw3d         \
--without-xim           \
--without-gpm           \
--without-dbus          \
--without-gconf         \
--without-gsettings     \
--without-selinux       \
--without-gnutls        \
--without-makeinfo      \
--without-compress-info ; make bootstrap ; make install",
         path => "/usr/bin:/bin",
         creates => "/home/vagrant/emacs/bin/emacs",
         cwd => "/home/vagrant/emacs.git",
      }      
}
