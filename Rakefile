task :default => 'emacs_vagrant:build'

namespace :emacs_vagrant do
  desc "Build the vagrant provisioning environment for Emacs"

  require 'vagrant'
  
  task :build => [:vagrantup,
                  :emacs_checkout, 
                  "puppet/modules/local/manifests/myrepo.pp"] do
  end

  desc "Kill the local emacs src repository and the VM image"
  task :fullclean do
    sh "rm -rf emacs.git"
    env = Vagrant::Environment.new
    env.primary_vm.destroy
  end

  desc "Clean the provisioning environment"  
  task :clean do
    sh "rm -rf puppet/modules/local/manifests/myrepo.pp"
  end

  task :suspend do
    desc "Suspend any running VM"
    env = Vagrant::Environment.new
    env.primary_vm.suspend if env.primary_vm.state == :running
  end

  task :vagrantup do
    desc "Bring up the vagrant VM"
    env = Vagrant::Environment.new
    env.cli("up") if env.primary_vm.state != :running
    #env.cli("provision")
  end

  task :emacs_checkout do
    # Use either a user specified url or the default savannah one
    emacs_git_url = ENV["emacs_git_url"] || "git://git.savannah.gnu.org/emacs.git"
    unless Dir.exist?("emacs.git")
      sh "git clone #{emacs_git_url} emacs.git"
    end
  end

  file "puppet/modules/local/manifests/myrepo.pp" => ["puppet/modules/local/manifests"] do
    File.open("puppet/modules/local/manifests/myrepo.pp", "w") do |file|
      file.write("class local::myrepo { $my_repo_src = \"#{ENV['myrepo']}\"}")
    end
  end
  
end

# End
