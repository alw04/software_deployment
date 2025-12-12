#!/bin/bash

SOFTWARE=$1
SOFTWARE_VERSION=$2

mkdir -p roles/$SOFTWARE/defaults

cat >roles/$SOFTWARE/defaults/main.yml <<EOL
---
name: "$SOFTWARE"
${SOFTWARE}_default_version: "$SOFTWARE_VERSION"
${SOFTWARE}_version: "{{ ${SOFTWARE}_default_version }}"
EOL

mkdir -p roles/$SOFTWARE/tasks/versions

cat >roles/$SOFTWARE/tasks/main.yml <<EOL
---
- include_tasks: "versions/{{ ${SOFTWARE}_version }}.yml"
EOL

cat >roles/$SOFTWARE/tasks/versions/$SOFTWARE_VERSION.yml <<EOL
---
- include_role:
    name: software_install
  vars:
    ${SOFTWARE}_version: "$SOFTWARE_VERSION"
EOL
