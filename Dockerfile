# Use miniconda with python 3 built on CentOS7
FROM conda/miniconda3-centos7:latest

# Set the working directory to /root
WORKDIR /root

# Copy current directory contents into the container at /root
ADD atnlp_rsa requirements.txt /root/

# Install system packages
RUN yum install -y git ssh 

# Add extra repos (only for xgboost)
#RUN conda config --add channels conda-forge

# Install minimal set of dependencies
RUN conda install -y --file requirements.txt

# NOTE: if we want to install keras, do it with no deps:
# RUN pip install keras --no-deps (or try conda equiv)

# Install atnlp and dependencies
RUN mkdir /root/.ssh && mv atnlp_rsa .ssh \
    && ssh-keyscan bitbucket.org > /root/.ssh/known_hosts \
    && ssh-agent bash -c 'ssh-add .ssh/atnlp_rsa; git clone git@bitbucket.org:wedavey/atnlp.git' \
    && cd atnlp; python setup.py install

# Install reuters dataset for testing purposes
RUN install_reuters.py

# clean up ssh keys
RUN rm -r .ssh

# Run a test
CMD ["./test.py"]
