#  vEXOS Vagrant Box



# Notes
For versions below 30.2, EXOS expects ISO on IDE Secondary Master, there isn't any configurable option in packer to specific where the installer is mounted.

Hack to mitigate the issue using `vboxmanage` command option `storageattach`:
```json
    "vboxmanage":[
      ["modifyvm", "{{.Name}}", "--memory", "1024"],
 +     ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "dvddrive", "--medium", "{{user iso_full_path}}"]
    ],
    "vboxmanage_post":[
 +     ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "dvddrive", "--medium", "none"],
      ["modifyvm", "{{.Name}}", "--nic1", "bridged"],
      ["modifyvm", "{{.Name}}", "--bridgeadapter1", "en0"]
    ]
```   
