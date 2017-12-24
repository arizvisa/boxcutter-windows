# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "vagrant-eval-win2012r2-datacenter-ssh"
  config.vm.box = "eval-win2012r2-datacenter-ssh"

  # Port forward WinRM and RDP
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct:true
  config.vm.communicator = "winrm"
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct:true
  # Port forward SSH
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct:true

  config.vm.provider :virtualbox do |v, override|
    v.gui = true
    v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
    v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]
  end

  ["vmware_fusion", "vmware_workstation"].each do |provider|
    config.vm.provider provider do |v, override|
      v.gui = true
      v.vmx["ethernet0.virtualDev"] = "vmxnet3"
      v.vmx["RemoteDisplay.vnc.enabled"] = "false"
      v.vmx["RemoteDisplay.vnc.port"] = "5900"
      v.vmx["scsi0.virtualDev"] = "lsisas1068"
    end
  end
end
