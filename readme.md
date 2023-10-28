# Navidrome Ansible Playbook

Ansible playbook for a basic setup of [Navidrome](https://github.com/navidrome/navidrome), [AskNavidrome](https://github.com/rosskouk/asknavidrome), Caddy and a few extra tools on a 
homeserver running Ubuntu. Additionally, this configures a dyndns client to maintain domain-to-IP mappings.

## Prerequisites / Notes
This playbook comes with minimum configuration and does not aim to be a generic Navidrome role but rather an example.
Here is my current setup using this playbook:

- Server with Ubuntu Server 22.04.3 LTS running on Intel® Celeron® N3450 with 4GB of RAM 
- Namecheap domain (5$/year) with cloudflare.com DNS configured in proxy mode (free)
- cloudflare.com API key with Zone.Zone, Zone.DNS permissions to configure IP addresses
  In theory any free domains like duckdns etc supported by inadyn should work too but cloudflare proxying your real ip is nice. 
- Cloudflare requires a WAF rule to be configured for the connection between navidrome and skill to function. [See here](https://github.com/rosskouk/asknavidrome/issues/28#issuecomment-1764041176).
- Setting up AskNavidrome (an Alexa Skill) requires additional configurations, as covered [here](https://rosskouk.github.io/asknavidrome/) 
- navi.home local LAN domains are configured outside of this playbook via dnsmasq on a router
- No docker containers were harmed during the making of this playbook

## Set-up

### Setup your server (managed node)

#### 1.1. Create a sudo user (or use existing one)
This playbook has only been tested with Ubuntu Server 22.04.3 LTS.
```
sudo adduser ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
sudo chmod 0440 /etc/sudoers.d/ansible
```

### Setup your local host (control node)

#### 2.1. Install Ansible 
Ansible is an agent-less automation tool that you install on a single host (referred to as the control node).
From the control node, Ansible can manage remote machines and other devices (referred to as managed nodes) remotely via SSH.

##### Linux
To install on Linux (requires Python 3.9) use:
```
python3 -m pip install --user ansible
```
More info on Linux Ansible installation can be found [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

##### Windows
To use Windows as your control node you will need [WSL](https://learn.microsoft.com/en-us/windows/wsl/faq) installed
In admin CMD or PS run the following:

```
wsl --install 
wsl --set-version Ubuntu-22.04 2 
```
Log into your WSL Ubuntu
```
wsl
sudo pip install ansible
```

#### 2.2. Set-up ssh keys
The most common method Ansible uses to manage remote nodes is via an SSH connection.    
On your local host, create a new SSH key (or you can use an existing SSH key if you have one).    
Then, copy that key to the ~/.ssh/authorized_keys directory in the user's home on your server.
```
ssh-keygen
ssh-copy-id ansible@<your server ip address>
```

### Setup and run playbook

- Clone or download this repository
- Copy folder `ansible/inventories/example` into `ansible/inventories/prod`
- Set up your server's IP in `ansible/inventories/prod/hosts.yml`
- Set up variables in `ansible/inventories/prod/group_vars/all.yml`
- Run `ansible-playbook -i inventories/prod/hosts.yml playbook.yml -v`
- You can optionally use `--tags` to run parts of the playbook

# Potential TODO 
- Prometheus / node_exporter / Grafana  monitoring