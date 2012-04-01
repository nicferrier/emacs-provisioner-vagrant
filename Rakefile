task :default => "puppet/modules/local/manifests/init.pp"

namespace :emacs_vagrant do
  
  task :emacs_checkout => :git_src do
    sh "git clone #{git_src} emacs.git"
  end
  
  file "puppet/modules/local" => ["puppet/modules"] do
    mkdir "puppet/modules/local"
  end
  
  file "puppet/modules/local/manifests" => ["puppet/modules/local"] do
    mkdir "puppet/modules/local/manifests"
  end
  
  file "puppet/modules/local/manifests/init.pp" => ["puppet/modules/local/manifests"] do
    File.open("puppet/modules/local/manifests/init.pp", "w") do |file|
      file.write("
class local {
    
}
")
end
end
end


# End
