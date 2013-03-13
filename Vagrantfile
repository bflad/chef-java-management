require 'berkshelf/vagrant'

# We'll mount the Chef::Config[:file_cache_path] so it persists between
# Vagrant VMs
host_cache_path = File.expand_path("../.cache", __FILE__)
guest_cache_path = "/tmp/vagrant-cache"

# ensure the cache path exists
FileUtils.mkdir(host_cache_path) unless File.exist?(host_cache_path)

# Data bags path gets mounted and will be shared between boxes
data_bags_path = "../chef-repo/data_bags"

# ensure the data_bags path exists
FileUtils.mkdir("../chef-repo") unless File.exist?("../chef-repo")
FileUtils.mkdir(data_bags_path) unless File.exist?(data_bags_path)

Vagrant::Config.run do |config|

  config.vm.define :centos6 do |dist_config|
    dist_config.vm.host_name = 'java-management-centos-6'
    dist_config.vm.box       = 'opscode-centos-6.3'
    dist_config.vm.box_url   = 'https://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-6.3_chef-10.18.2.box'
    
    dist_config.vm.customize [ "modifyvm", :id, "--memory", 1024 ]
    dist_config.vm.network :hostonly, '192.168.99.98'

    dist_config.vm.share_folder "cache", guest_cache_path, host_cache_path

    dist_config.vm.provision :chef_solo do |chef|
      chef.data_bags_path    = data_bags_path
      chef.provisioning_path = guest_cache_path
      chef.log_level         = :debug

      chef.json = {
        
      }

      chef.run_list = %w{
        recipe[java]
        recipe[java-management]
      }
    end
  end

  config.vm.define :ubuntu1204 do |dist_config|
    dist_config.vm.host_name = 'java-management-ubuntu-1204'
    dist_config.vm.box       = 'opscode-ubuntu-12.04'
    dist_config.vm.box_url   = 'https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box'
    
    dist_config.vm.customize [ "modifyvm", :id, "--memory", 1024 ]
    dist_config.vm.network :hostonly, '192.168.99.99'

    dist_config.vm.share_folder "cache", guest_cache_path, host_cache_path

    dist_config.vm.provision :chef_solo do |chef|
      chef.data_bags_path    = data_bags_path
      chef.provisioning_path = guest_cache_path
      chef.log_level         = :debug

      chef.json = {

      }

      chef.run_list = %w{
        recipe[java]
        recipe[java-management]
      }
    end
  end
end
