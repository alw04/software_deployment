#!/bin/bash
# Usage: ./add_software.sh <software_name> <version>

SOFTWARE="$1"
VERSION="$2"

if [ -z "$SOFTWARE" ] || [ -z "$VERSION" ]; then
  echo "Usage: $0 <software_name> <version>"
  exit 1
fi

mkdir -p "roles/$SOFTWARE/defaults"
cat > "roles/$SOFTWARE/defaults/main.yml" << EOF
---
name: "$SOFTWARE"
${SOFTWARE}_default_version: "$VERSION"
EOF

mkdir -p "roles/$SOFTWARE/tasks/versions"
cat > "roles/$SOFTWARE/tasks/main.yml" << EOF
---
- import_tasks: roles/software_install/tasks/entry.yml
EOF

cat > "roles/$SOFTWARE/tasks/versions/$VERSION.yml" << EOF
---
- include_role:
    name: software_install
EOF
