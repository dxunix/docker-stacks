#!/bin/bash
if [[ -z "${USER_PRI_KEY}" ]]; then
    private_key=${1}
else
    private_key=./work/${USER_PRI_KEY}
fi

echo "using private key $private_key for ${2}"
ssh -o "StrictHostKeyChecking no" -i ${private_key} -4NTL 8998:169.254.76.1:8998 glue@${2} &
jupyter notebook --NotebookApp.token='' --NotebookApp.password='' 