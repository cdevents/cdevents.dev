#!/usr/bin/env bash
#
# Build static content from the spec repo
set -exo pipefail

BASE_DIR="$( cd "$( dirname "$0" )/.." >/dev/null 2>&1 && pwd )"
STATIC_DIR="${BASE_DIR}/static"
DOCS_DIR="$(mktemp -d)"

# Clone the spec repo to pull the schemas
git clone https://github.com/cdevents/spec "${DOCS_DIR}"

# Serve versioned schemas
cd "${DOCS_DIR}"
for tag in $(git tag); do
    # Get the version by trimming the "v"
    version=$(printf '%s' "${tag}" | sed 's/^v//g')
    TARGET_SCHEMA_FOLDER="${STATIC_DIR}/${version}/schema"
    # Create the folder if it doesn't exists yet
    mkdir -p "${TARGET_SCHEMA_FOLDER}" || true

    git checkout "${tag}"
    for schema in schemas/*json; do
        # Extract the schema name from the schema id itself
        TARGET_SCHEMA=$(awk -F'/' '/"\$id"/{ print $6 }' "${schema}" | sed -e 's/",//g')
        # Copy the file to static with the new name
        cp "${schema}" "${TARGET_SCHEMA_FOLDER}/${TARGET_SCHEMA}"
    done

    # Starting with v0.4 we serve links schemas too
    if [[ -d schemas/links ]]; then
        pushd schemas
        mkdir "${TARGET_SCHEMA_FOLDER}/links" || true
        for schema in links/*json; do
            cp -r "${schema}" "${TARGET_SCHEMA_FOLDER}/${schema}"
            cp -r "${schema}" "${TARGET_SCHEMA_FOLDER}/${schema%.*}"
        done
        popd
    fi

    # Starting with v0.4 we serve the custom events schema
    if [[ -f custom/schema.json ]]; then
        cp custom/schema.json "${TARGET_SCHEMA_FOLDER}/custom"
        cp custom/schema.json "${TARGET_SCHEMA_FOLDER}/custom.json"
    fi
done
