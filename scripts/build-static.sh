#!/usr/bin/env bash
#
# Build static content from the spec repo
set -exo pipefail

BASE_DIR="$( cd "$( dirname "$0" )/.." >/dev/null 2>&1 && pwd )"
STATIC_DIR="${BASE_DIR}/static"
DOCS_DIR="$(mktemp -d)"

# Clone the spec repo to pull the schemas
git clone https://github.com/cdevents/spec ${DOCS_DIR}

# Serve versioned schemas
cd "${DOCS_DIR}"
for tag in $(git tag); do
    # Get the version by trimming the "v"
    version=$(printf $tag | sed 's/^v//g')
    TARGET_SCHEMA_FOLDER="${STATIC_DIR}/${version}/schema"
    # Create the folder if it doesn't exists yet
    mkdir -p ${TARGET_SCHEMA_FOLDER} || true

    git checkout "${tag}"
    for schema in $(ls schemas/*json); do
        # Extract the schema name from the schema id itself
        TARGET_SCHEMA=$(awk -F'/' '/"\$id"/{ print $6 }' $schema | sed -e 's/",//g')
        # Copy the file to static with the new name
        cp ${schema} ${TARGET_SCHEMA_FOLDER}/${TARGET_SCHEMA}
    done
done
