#!/bin/bash
if [[ -z "${USER_PRI_KEY}" ]]; then
    private_key=${1}
else
    private_key=${HOME}/work/${USER_PRI_KEY}
fi

echo "using private key $private_key for ${2}"
echo "alias aws-connect=\"ssh -o \\\"StrictHostKeyChecking no\\\" -i ${private_key} -4NTL 8998:169.254.76.1:8998 glue@${2}\"" >> ${HOME}/.profile 
ssh -o "StrictHostKeyChecking no" -i ${private_key} -4NTL 8998:169.254.76.1:8998 glue@${2} &
cd work
# jupyter notebook --NotebookApp.token='' --NotebookApp.password='' 
jupyter notebook 