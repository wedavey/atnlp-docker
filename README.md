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
docker run --rm -v $(pwd)/data:/data atnlp prep
```

To use alternative datasets, convert them to the required 
txt file format and place them in a local directory
that will be mounted to the docker image. 


### Train models

Run training
```bash
docker run --rm -v $(pwd)/data:/data atnlp train 
```

Models can be specified by setting the `MODELS` environment variable, eg:  
```bash
docker run --rm -e "MODELS=wordmatch svm" -v $(pwd)/data:/data atnlp train 
```

### Evaluate models

```bash
docker run --rm -e "MODELS=wordmatch svm" -v $(pwd)/data:/data atnlp eval
```


## Authors

- **Will Davey** - main developer

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


