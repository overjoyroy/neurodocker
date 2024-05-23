FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

ARG COMPILER_THREADS=4

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    gnupg \
    cmake \
    python3 \
    python2 \
    python3-pip\
    g++ 


RUN mkdir /fsl_install && wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py -P /fsl_install

RUN python2.7 /fsl_install/fslinstaller.py -d /usr/local/fsl

RUN apt-get update && apt-get install -y --no-install-recommends make

COPY ./ants_build_instructions.sh /ants/

RUN cd /ants && chmod 777 -R /ants \
    && ./ants_build_instructions.sh ${COMPILER_THREADS}

ENV PATH=${PATH}:/ants/install/bin:/usr/local/fsl/bin

RUN python3 -m pip install \
    numpy \ 
    pandas \ 
    nipype\
    scikit-learn \ 
    matplotlib \
    tqdm \
    scipy \
    wheel \
    networkx \
    nipy \
    nipype\
    matplotlib\
    jupyter \
    jupyterlab \
    pymc3 \ 
    graphviz \
    statsmodels \
    bctpy

RUN mkdir -p /.config/matplotlib && chmod 777 -R /.config/

RUN echo "alias python=python3.7" >> /etc/bash.bashrc && /bin/bash -c 'source /etc/bash.bashrc'

ENV MPLCONFIGDIR='/.config/matplotlib'

# COPY /app/ /app/

ENV FSLOUTPUTTYPE='NIFTI_GZ'

SHELL ["/bin/bash", "-c"]

Run echo "alias python=python3.7" >> ~/.bashrc && \
    echo "alias python=python3.7" >> /etc/profile && source /etc/profile

ENV HOME=/home

RUN chmod -R 777 /home

RUN mkdir /data && chmod -R 777 /data

# ENTRYPOINT ["/bin/bash", "/app/autorun.sh"]
