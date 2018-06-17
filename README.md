# atnlp-docker

Docker image to deploy [atnlp](https://github.com/wedavey/atnlp) for document topic labelling.

## Technologies

`atnlp-docker` is built on the `conda/miniconda3-centos7` image

It uses the following technologies: 

- [docker](https://www.docker.com/) - containerization
- [CentOS7](https://www.centos.org/) - open source linux OS
- [miniconda](https://conda.io/miniconda.html) - datascience platform 
- [github](https://github.com/) - software development platform


## Prerequisites

- [Docker](https://www.docker.com/) - create an account and install (suggest [Community Edition](https://www.docker.com/community-edition))

## Usage

The following describes how to prepare input data, train and evaluate models
and provide predictions on unseen data. 

The set of models used throughout is controlled via 
the `MODELS` environment variable. Set as follows when when running the docker container:  
```bash
docker run -e "MODELS=wordmatch svm" ...
```   
If not set a default model set will be chosen.


### Input data
`atnlp-docker` expects the input data to be placed in 
`/data`. It should comprise the following
files: 
- `data_train.txt` - raw text, one document per line
- `data_test.txt` - raw text, one document per line
- `labels_train.txt` - one-hot flags, one category per column, one doc per line
- `labels_test.txt` - one-hot flags, one category per column, one doc per line   

The Reuters dataset is provided for example with the docker. 
To install issue:
```bash
docker run --rm -v $(pwd)/data:/data wedavey/atnlp prep
```

To use alternative datasets, convert them to the required 
txt file format and place them in a local directory
that will be mounted to the docker image. 


### Train models

```bash
docker run --rm -v $(pwd)/data:/data wedavey/atnlp train 
```

The models are saved as `.pkl` files in the `/data` path.

### Evaluate models

```bash
docker run --rm -v $(pwd)/data:/data wedavey/atnlp eval
```

This produces an html report (`summary.html`) in the `/data` path.   

### Predict topic labels

Predict topic labels for an input data file located in the `/data` path.
Here we have used the test data set, while in production this 
would typically be some unseen data.  

```bash
docker run --rm -v $(pwd)/data:/data wedavey/atnlp pred data_test.txt
```

This produces text files (`pred_<model name>.txt`) containing the 
predictions in a one-hot format in the `/data` path. 

## Authors

- **Will Davey** - main developer

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


