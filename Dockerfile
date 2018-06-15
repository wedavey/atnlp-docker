# Use miniconda with python 3 built on CentOS7
FROM conda/miniconda3-centos7:latest

# Set globals
WORKDIR /app
ENV APPDIR /app
ENV DATADIR /data
ENV MODELS wordmatch svm logreg

# Install system packages
RUN yum install -y git mesa-libGL ssh wget which

# Install atnlp
COPY environment.yml /app/environment.yml
RUN conda update conda -c conda-forge -y
RUN conda env create -n atnlp -f environment.yml \
    && rm -rf /usr/local/pkgs/*
ENV PATH /usr/local/envs/atnlp/bin:$PATH

# Install reuters dataset for testing purposes
RUN install_reuters.py

# Install scripts
COPY . /app/
ENV PATH ${APPDIR}:$PATH

# Prepare data volume
VOLUME ${DATADIR}