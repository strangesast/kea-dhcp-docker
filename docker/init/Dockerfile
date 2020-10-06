from kea-dhcp-docker_base

run apt-get update && apt-get install -y \
  postgresql \
  postgresql-client

cmd ["kea-admin", "db-init", "pgsql", "-h", "db", "-u", "kea", "-p", "kea", "-n", "kea_test"]
