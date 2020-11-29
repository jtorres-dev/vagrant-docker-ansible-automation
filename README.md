# Configuration Management #
This directory is composed of two other directories: `ansible/` and `vagrant/`.
The goal of this configuration was to incorporate *Vagrant* and *Docker* with an *Ansible* configuration on 3 virtual machines. **VM1** is setup to have NAT and Host-only interfaces, **VM2** and **VM3** are setup to have Host-only interfaces (*VirtualBox*). **VM1** will have SSH listening on port 4452, DNS, UFW with the correct allowed connections, and finally NFS to share files to **VM2** and **VM3**.
<br/>

##### Vagrant #####
*Vagrant* creates **VM1**, **VM2**, and **VM3**. All the VMs are updated, installed with dependencies, and creates **VM1** with SSH listening on port 4452. **VM1** has an *Ansible* *Docker* container built into the machine during the first provision.
<br/>

##### Docker #####
*Docker* is used as a container for *Ansible* to run playbooks from **VM1**. **VM1's** *Docker* container will configure **VM1**, **VM2**, and **VM3** via *Ansible* playbooks while assisting with ssh key sharing.
<br/>

##### Ansible #####
*Ansible* contains playbooks to be ran by the server **VM1** and the clients **VM2** and **VM3**. Each playbook in the `ansible/` directory contains the plays that will setup the small network to meet the requirements for the configuration.
<br/>
<br/>


## Disclaimer ##
It is assumed that you will have *Vagrant* and *VirtualBox* installed. There are some manual steps that cannot be automated such as passwords needed for the machines in the *Ansible* playbooks. The default username and password from *Vagrant* remains the same to simplify this creation process: `user: vagrant` and `pass: vagrant`. For this configuration, the NAT connection from **VM2** and **VM3** is only needed for *Vagrant* and is still setup to work as if **VM2** and **VM3** are Host-only machines.
<br/>
<br/>

## Steps ##

#### 1. Clone this repository, and navigate to `vagrant/`. ####
<br/>

#### 2. Run the command: ####
```
vagrant up
```
<br/>

#### 3. Once the provision is done, **VM1's** `ssh` port will change from port 22 to port 4452. Open `Vagrantfile` in a text editor and uncomment: ####
```
  ...

  # if machine[:hostname] == "vm1"
  #   node.vm.network "forwarded_port", guest: 4452, host: 4452, id: "ssh"
     #  node.ssh.guest_port = 4452
  # end

  ...
```
<br/>

#### 4. Reload the `Vagrantfile` by typing: ####
```
vagrant reload vm1 --provision
```
<br/>

#### 5. `ssh` into **VM1** with: ####
```
vagrant ssh vm1
```
<br/>

#### 6. Run the command: ####
```
cd /ansible/ && sudo su
```
<br/>

#### 7. Run the *Ansible* container: ####
```
docker run -it ansible
```

*Note: The `ansible/entry_point.sh` script creates the host entries for the *Ansible* inventory and prompts you for all three key exchanges to **VM1**, **VM2**, and **VM3**. The `ansible-playbook` command will also be ran so you will need to provide the `BECOME password` for all 3 machines. **VM1**, **VM2**, and **VM3** should all work properly with this setup and take into effect the changes from *Ansible* to meet the requirements for this configuration.*
