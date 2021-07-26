# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/base-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y \
    openssh-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Install pyarrow
RUN conda install --quiet --yes --satisfied-skip-solve \
    'sparkmagic' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    mkdir  /home/${NB_USER}/.sparkmagic/ && \
    wget -O  /home/${NB_USER}/.sparkmagic/config.json https://raw.githubusercontent.com/jupyter-incubator/sparkmagic/master/sparkmagic/example_config.json 

USER root
# Install aws stuff
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    cd `pip show sparkmagic | grep Location | cut -f2 -d" "` && \
    jupyter-kernelspec install sparkmagic/kernels/sparkkernel && \
    jupyter-kernelspec install sparkmagic/kernels/pysparkkernel 

USER $NB_UID
WORKDIR $HOME





