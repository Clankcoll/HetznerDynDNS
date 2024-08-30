# Hetzner Dynamic DNS Daemon  

A simple daemon to continuously update Hetzner DNS
*A* and *AAAA* records for your server with a dynamic IP address.

It features support for multiple subdomain records with painless
configuration and administration.

## Installation

### Prebuilt packages

Officially supported operating systems:

- Alpine Linux
- Arch Linux ([AUR](https://aur.archlinux.org/packages/hetzner_ddns/))
- Debian / Ubuntu
- Docker ([Docker Hub](https://hub.docker.com/r/filiparag/hetzner_ddns))
- Fedora / openSUSE ([Copr](https://copr.fedorainfracloud.org/coprs/filiparag/hetzner_ddns/))
- FreeBSD ([Ports tree](https://www.freshports.org/dns/hetzner_ddns/))
- NetBSD

Packages for the latest stable version can be found
[here](https://github.com/filiparag/hetzner_ddns/releases/latest). ATTENTION this is going Back to the Origin of this fork since most likely i will not keep it very much up to date!
Maybe Once or Twice in a Year.

Feel free to contribute to [first-party support](./release) for other operating systems.

### Manual Installation

Dependencies: `awk`, `curl`, `jq`.

```ini
# Download
git clone https://github.com/Clankcoll/HetznerDynDNS.git
cd hetzner_ddns

# Install
sudo make install

# systemd service
sudo make systemd

# FreeBSD service
sudo make freebsd-rc

# NetBSD service
sudo make netbsd-rc

# OpenRC service
sudo make openrc
```

To obtain an **API key**, go to [Hetzner DNS Console](https://dns.hetzner.com/settings/api-token).

### Getting the Zone ID

To get the Zone ID please run following
```´sh
curl --location 'https://dns.hetzner.com/api/v1/zones?Auth-API-Token=MYSUPERCOOLAPIKEY' | jq -r '.zones[] | "\(.name) \(.id)"'

```
The Output will look something like:

```
geek.tech gb9gPjc5Ao9wK3ia42qSuQ
foo.bar ZWidz55jw5qdMnBlPDasNC
```
Now you need to choose which Zone ID you need, that would be the Right Side that is the Zone ID

## Configuration

Configuration file is located at `/usr/local/etc/hetzner_ddns.conf`

```sh
# Seconds between updates / TTL value
interval='60'

# Hetzner DNS API key
key='MYSUPERCOOLAPIKEY'

# Top level domain name Zone ID
zone='MYSUPERCOOLZONEID'

# Space separated host subdomains (@ for domain itself)
records='homelab media vpn'
```

### Configuration for prebuilt packages

Default configuration location differs in prebuilt packages:

- Linux distributions: `/etc/hetzner_ddns.conf`
- FreeBSD: `/usr/local/etc/hetzner_ddns.conf`
- NetBSD: `/usr/pkg/etc/hetzner_ddns.conf`

### Manage records for multiple domains

Currently, this utility supports management of one domain per daemon.
If you have multiple domains, use CNAME records to point them to one
the daemon will manage, as shown in the following example:

```sh
# Managed domain (master.tld)
@		IN	A	    1.2.3.4
@		IN	AAAA	1:2:3:4::

# Other domain
service		IN	CNAME	master.tld.
```

### Multiple daemon instances for **systemd**

If your operating system relies on systemd, you can easily run
multiple daemons as shown below:

```ini
# Create configuration file for foobar.tld domain
sudo cp -p /usr/local/etc/hetzner_ddns.conf.sample /usr/local/etc/hetzner_ddns.foobar.conf

# Modify created file to reflect your preferences

# Enable and start foobar.tld's daemon
sudo systemctl enable hetzner_ddns@foobar
```

## Usage

**Run on startup**
```ini
# systemd
sudo systemctl enable hetzner_ddns

# FreeBSD and NetBSD
sudo service hetzner_ddns enable

# OpenRC
sudo rc-update add hetzner_ddns
```

**Start/Stop**
```ini
# systemd
sudo systemctl start/stop hetzner_ddns

# FreeBSD, NetBSD and OpenRC
sudo service hetzner_ddns start/stop
```

**Log file** is located at `/var/log/hetzner_ddns.log`

### Credits
EveryOne
