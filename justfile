# SPDX-FileCopyrightText: 2024 Oliver Lorenz
#
# SPDX-License-Identifier: GPL-3.0-or-later

# show help by default
default:
    @{{ just_executable() }} --list --justfile {{ justfile() }}

lint:
    ansible-lint .
