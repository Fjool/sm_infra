# SuperMOO infrastructure
Environment initialisation for SuperMOO project.
Provisions a Vagrant VM running Ubutntu.

This initialisation was tested on Windows 10.

- Clone these repos:
  - Directory structure:
    - supermoo/
      - sm_infra/   : https://github.com/Fjool/sm_infra.git
      - supermoo/   : https://github.com/Fjool/SuperMOO-Reboot.git

- Install vagrant: https://www.vagrantup.com/docs/installation/
- From sm_infra:
  - vagrant up

Provisioning might take a while, but once complete, the environment should be ready to use.

- Development folder supermoo accessible at /srv/supermoo on VM
- Currently: rails s -b 0.0.0.0 to run the server (this will change)
- Server visible at: 44.44.44.234:3000 from host machine.
