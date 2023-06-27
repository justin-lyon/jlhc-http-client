sf org create scratch --alias $1 --definition-file config/project-scratch-def.json --no-namespace

sf package install --target-org $1 --package $2 --wait 10