install: script config docs

script: hetzner_ddns.sh
	@mkdir -p $(prefix)/usr/local/bin
	@install -m 0755 -p hetzner_ddns.sh $(prefix)/usr/local/bin/hetzner_ddns

config: hetzner_ddns.conf
	@mkdir -p $(prefix)/usr/local/etc
	@install -m 0644 -p hetzner_ddns.conf $(prefix)/usr/local/etc/hetzner_ddns.conf.sample
	@test -f $(prefix)/usr/local/etc/hetzner_ddns.conf || \
		install -m 0644 -p hetzner_ddns.conf $(prefix)/usr/local/etc/hetzner_ddns.conf

rc.d: hetzner_ddns.rc
	@mkdir -p $(prefix)/usr/local/etc/rc.d
	@install -m 0755 -p hetzner_ddns.rc $(prefix)/usr/local/etc/rc.d/hetzner_ddns

systemd: hetzner_ddns.service
	@mkdir -p $(prefix)/usr/local/etc/systemd/system
	@install -m 0755 -p hetzner_ddns.service $(prefix)/usr/local/etc/systemd/system/hetzner_ddns.service

openrc: hetzner_ddns.init
	@mkdir -p $(prefix)/usr/local/etc/init.d
	@install -m 0755 -p hetzner_ddns.init $(prefix)/usr/local/etc/init.d/hetzner_ddns

docs: hetzner_ddns.1.man
	@mkdir -p $(prefix)/usr/local/share/man/man1
	@install -m 0644 -p hetzner_ddns.1.man $(prefix)/usr/local/share/man/man1/hetzner_ddns.1
	@test -f $(prefix)/usr/local/share/man/man1/hetzner_ddns.1.gz || \
		gzip -f $(prefix)/usr/local/share/man/man1/hetzner_ddns.1
	@test -f $(prefix)/usr/local/share/man/man1/hetzner_ddns.1 && \
		rm -f $(prefix)/usr/local/share/man/man1/hetzner_ddns.1 || \
		true

remove:
	@rm -f 	$(prefix)/usr/local/bin/hetzner_ddns \
			$(prefix)/usr/local/etc/hetzner_ddns.conf.sample \
			$(prefix)/usr/local/share/man/man1/hetzner_ddns.1.gz \
			$(prefix)/usr/local/etc/rc.d/hetzner_ddns \
			$(prefix)/usr/local/etc/systemd/system/hetzner_ddns.service \
			$(prefix)/usr/local/etc/init.d/hetzner_ddns
