<!--
SPDX-FileCopyrightText: 2024 Oliver Lorenz

SPDX-License-Identifier: GPL-3.0-or-later
-->

# Matterbridge Ansible role

This is an [Ansible](https://www.ansible.com/) role which installs [Matterbridge](https://github.com/42wim/matterbridge) to run as a [Docker](https://www.docker.com/) container wrapped in a systemd service.

This role _implicitly_ depends on:

- [`com.devture.ansible.role.playbook_help`](https://github.com/devture/com.devture.ansible.role.playbook_help)
- [`com.devture.ansible.role.systemd_docker_base`](https://github.com/devture/com.devture.ansible.role.systemd_docker_base)

Check [defaults/main.yml](defaults/main.yml) for the full list of supported options.

For an Ansible playbook which integrates this role and makes it easier to use, see the [mash-playbook](https://github.com/mother-of-all-self-hosting/mash-playbook).
