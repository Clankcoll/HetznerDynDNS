FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache bash curl jq gawk make gcc libc-dev

# Set the working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/Clankcoll/HetznerDynDNS.git /app

# Run installation commands
RUN make install && RUN make systemd

# Optional: If you need to support other init systems, add the respective commands
# RUN make freebsd-rc
# RUN make netbsd-rc
# RUN make openrc

# Set the default command
CMD ["/app/hetzner_ddns.sh"]
