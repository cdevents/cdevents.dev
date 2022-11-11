#!/usr/bin/env bash
#
# Build static content from the spec repo
set -exo pipefail

BASE_DIR="$( cd "$( dirname "$0" )/.." >/dev/null 2>&1 && pwd )"
STATIC_DIR="${BASE_DIR}/static"
DOCS_DIR="${BASE_DIR}/content/en/docs"

# Serve static images
cp ${DOCS_DIR}/images/* ${STATIC_DIR}/images/
sed -i -e 's/\(images\/[a-zA-Z\-]*\.svg\)/\/\1/g' ${DOCS_DIR}/*.md

# Serve versioned schemas
cd ${DOCS_DIR}
ORIGINAL_REVISION=$(git rev-parse HEAD)
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
git checkout ${ORIGINAL_REVISION}