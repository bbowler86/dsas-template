FROM ubuntu:18.04

USER root
EXPOSE 8888

# create analysis directory and copy all the files to it
RUN mkdir /analysis
WORKDIR /analysis
COPY . /analysis

# setup and install Miniconda3-4.7.12
RUN apt-get update -y
RUN apt-get install -y wget vim
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.7.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

# create and activate DSAS environment
RUN /opt/conda/condabin/conda init bash
RUN /opt/conda/condabin/conda env create -f /analysis/container-files/conda-environment.yaml
RUN echo "conda activate dsas" >> ~/.bashrc
COPY ./container-files/sitecustomize.py /opt/conda/envs/dsas/lib/python3.6/site-packages/

# install pip requirements.txt
RUN /opt/conda/envs/dsas/bin/pip install -r /analysis/container-files/requirements.txt

# setting up jupyter
RUN /opt/conda/envs/dsas/bin/jupyter notebook --generate-config
RUN mkdir -p /opt/conda/envs/dsas/share/jupyter/lab/settings/
COPY ./container-files/overrides.json /opt/conda/envs/dsas/share/jupyter/lab/settings/overrides.json
