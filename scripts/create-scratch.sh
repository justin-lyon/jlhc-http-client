echo "...Creating new Scratch Org $1"
sf org create scratch --set-default --alias $1 --definition-file config/project-scratch-def.json

echo "...Pushing metadata to $1"
sf project deploy start --source-dir force-app
