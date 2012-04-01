task :default => 'emacs_vagrant:build'

namespace :emacs_vagrant do
  desc "Build the vagrant provisioning environment for Emacs"
  
  task :build => [:emacs_checkout, 
                  "puppet/modules/local/manifests/init.pp"] do
  end
  
  task :clean do
    desc "Clean the provisioning environment"
    sh "rm -rf puppet/modules/local"
    sh "rm -rf emacs.git"
  end

  task :emacs_checkout do
    # Use either a user specified url or the default savannah one
    emacs_git_url = ENV["emacs_git_url"] || "git://git.savannah.gnu.org/emacs.git"
    unless Dir.exist?("emacs.git")
      sh "git clone #{emacs_git_url} emacs.git"
    end
  end
  
  task :puppetvcs_checkout do
    puppetvcs_git_url = ENV["puppetvcs_git_url"] || "git://github.com/puppetlabs/puppet-vcsrepo.git"
    unless Dir.exist?("puppetvcs.git")
      sh "git clone #{puppetvcs_git_url} puppetvcs.git"
    end
  end

  file "puppet/modules/local" => ["puppet/modules"] do
    mkdir "puppet/modules/local"
  end
  
  file "puppet/modules/local/manifests" => ["puppet/modules/local"] do
    mkdir "puppet/modules/local/manifests"
  end
  
  file "puppet/modules/local/manifests/init.pp" => ["puppet/modules/local/manifests", "puppet/modules/local/manifests/myrepo.pp"] do
    cp "puppet-local-templates/emacs-exec.pp", "puppet/modules/local/manifests/init.pp"
  end

  file "puppet/modules/local/manifests/myrepo.pp" => ["puppet/modules/local/manifests"] do
    File.open("puppet/modules/local/manifests/myrepo.pp", "w") do |file|
      file.write("class local::myrepo { $my_repo_src = '#{ENV['myrepo']}'}")
    end
  end
  
end

# End
