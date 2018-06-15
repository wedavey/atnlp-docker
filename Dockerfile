# Use miniconda with python 3 built on CentOS7
FROM conda/miniconda3-centos7:latest

# Install system packages
RUN yum install -y git mesa-libGL ssh which 

# Set the working directory
WORKDIR /app
ENV APPDIR /app

# Install requirements 
COPY environment.yml /app/environment.yml
RUN conda config --add channels conda-forge \
    && conda update conda -y \
    && conda env create -n atnlp -f environment.yml \
    && rm -rf /usr/local/pkgs/*

# Activate atnlp environment
ENV PATH /usr/local/envs/atnlp/bin:$PATH

# Install atnlp and cleanup key
RUN mkdir /root/.ssh
COPY atnlp_rsa /root/.ssh/
RUN ssh-keyscan bitbucket.org > /root/.ssh/known_hosts \
    && ssh-agent bash -c 'ssh-add /root/.ssh/atnlp_rsa; git clone git@bitbucket.org:wedavey/atnlp.git' \
    && cd atnlp; python setup.py install
RUN rm -r /root/.ssh

# Install reuters dataset for testing purposes
RUN install_reuters.py

# Install scripts
COPY . /app/

# Prepare data volume
VOLUME /data
ENV DATADIR /data

# Set list of algorithms 
ENV MODELS wordmatch svm logreg
