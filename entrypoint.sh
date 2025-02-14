#!/bin/sh
# Auth
echo "$INPUT_SECRETS" > /secrets.json
gcloud auth activate-service-account --key-file=/secrets.json
rm /secrets.json

# Sync files to bucket
echo "Syncing bucket $BUCKET ..."
gsutil -m rsync -r -c -d -x "$INPUT_EXCLUDE" /github/workspace/$INPUT_SYNC_DIR_FROM gs://$INPUT_BUCKET/$INPUT_SYNC_DIR_TO
if [ $? -ne 0 ]; then
    echo "Syncing failed"
    exit 1
fi
echo "Done."
