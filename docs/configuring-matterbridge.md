<!--
SPDX-FileCopyrightText: 2020 - 2024 MDAD project contributors
SPDX-FileCopyrightText: 2020 - 2024 Slavi Pantaleev
SPDX-FileCopyrightText: 2020 Aaron Raimist
SPDX-FileCopyrightText: 2020 Chris van Dijk
SPDX-FileCopyrightText: 2020 Dominik Zajac
SPDX-FileCopyrightText: 2020 Mickaël Cornière
SPDX-FileCopyrightText: 2022 François Darveau
SPDX-FileCopyrightText: 2022 Julian Foad
SPDX-FileCopyrightText: 2022 Warren Bailey
SPDX-FileCopyrightText: 2023 Antonis Christofides
SPDX-FileCopyrightText: 2023 Felix Stupp
SPDX-FileCopyrightText: 2023 Pierre 'McFly' Marty
SPDX-FileCopyrightText: 2024 - 2025 Suguru Hirahara
SPDX-FileCopyrightText: 2024 Oliver Lorenz

SPDX-License-Identifier: AGPL-3.0-or-later
-->

# Setting up Matterbridge

This is an [Ansible](https://www.ansible.com/) role which installs [Matterbridge](https://github.com/42wim/matterbridge) to run as a [Docker](https://www.docker.com/) container wrapped in a systemd service.

Matterbridge is the bridge which enables you to talk over various protocols, including IRC, Discord, Slack, etc.

See the project's [documentation](https://github.com/42wim/matterbridge/blob/master/README.md) to learn what Matterbridge does and why it might be useful to you.

## Adjusting the playbook configuration

To enable Matterbridge with this role, add the following configuration to your `vars.yml` file.

**Note**: the path should be something like `inventory/host_vars/mash.example.com/vars.yml` if you use the [MASH Ansible playbook](https://github.com/mother-of-all-self-hosting/mash-playbook).

```yaml
########################################################################
#                                                                      #
# matterbridge                                                         #
#                                                                      #
########################################################################

matterbridge_enabled: true

########################################################################
#                                                                      #
# /matterbridge                                                        #
#                                                                      #
########################################################################
```

### Add configuration for accounts and gateways

To use Matterbridge it is necessary to add configuration for accounts and gateways to `matterbridge_configuration_toml`.

See [this page](https://github.com/42wim/matterbridge/wiki/How-to-create-your-config) on the official documentation for details.

Here is an example of the configuration:

```yaml
matterbridge_configuration_toml:
  accounts:
    - protocol: matrix
      identifier: someidentifier
      configuration:
        Server: "https://matrix.example.com"
        Login: "{{ matterbridge_matrix_user }}"
        Password: "{{ matterbridge_matrix_password }}"
        RemoteNickFormat: "{NICK}: "
        NoHomeServerSuffix: "false"

  gateways:
    - name: "A Gateway"
      enable: "true"
      channels:

        - type: inout
          account: matrix.someidentifier
          channel: "!roomA:matrix.example.com"

        - type: inout
          account: matrix.freifunk
          channel: "!roomB:matrix.example.com"
```

## Installing

After configuring the playbook, run the installation command of your playbook as below:

```sh
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
```

If you use the MASH playbook, the shortcut commands with the [`just` program](https://github.com/mother-of-all-self-hosting/mash-playbook/blob/main/docs/just.md) are also available: `just install-all` or `just setup-all`

## Usage

After running the command for installation, the Matterbridge instance becomes available.

## Troubleshooting

### Check the service's logs

You can find the logs in [systemd-journald](https://www.freedesktop.org/software/systemd/man/systemd-journald.service.html) by logging in to the server with SSH and running `journalctl -fu matterbridge` (or how you/your playbook named the service, e.g. `mash-matterbridge`).
