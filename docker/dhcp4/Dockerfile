FROM kea-dhcp-docker_base

COPY kea-dhcp4.conf /usr/local/etc/kea/kea-dhcp4.conf

ENTRYPOINT ["/usr/local/sbin/kea-dhcp4"]
CMD ["-c", "/usr/local/etc/kea/kea-dhcp4.conf"]
