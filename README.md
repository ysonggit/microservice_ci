[![CircleCI](https://circleci.com/gh/ysonggit/microservice_ci.svg?style=svg)](https://circleci.com/gh/ysonggit/microservice_ci)

## Project Overview

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

## Setup the Environment

* Create a virtualenv and activate it
```
python3 -m venv ~/.devops
source ~/.devops/bin/activate
```
* Run `make install` to install the necessary dependencies

### Running `app.py` via Docker and Kubernetes

Make sure to create a repository at Docker hub as the dockerpath.

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`
4. Upload the docker image to your Docker hub: `./upload_docker.sh`
5. Delete Kubernetes Pods `kubectl delete pods <PodName>`

### CircleCI

Make sure to sign up on [circleci.com](https://www.circleci.com) with your github account.

1. Add a folder `.circleci` and create a `config.yml` file from template YAML (provided in proejct)
2. In the config.yml, add one step to download **hadolint** binary to and assign it executable permission
```
wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
            chmod +x /bin/hadolint
```

### Trouble Shooting

#### Dockerfile:11 DL3013 Pin versions in pip. Instead of `pip install <package>` use `pip install <package>==<version>`

In Dockerfile, specify the pip version:

```
RUN pip install --upgrade pip==20.2.3
```

#### recipe for target 'lint' failed

```
#!/bin/bash -eo pipefail
. venv/bin/activate
make lint
# See local hadolint install instructions:   https://github.com/hadolint/hadolint
# This is linter for Dockerfiles
hadolint Dockerfile
# This is a linter for Python source code linter: https://www.pylint.org/
# This should be run from inside a virtualenv
pylint --disable=R,C,W1203 app.py
make: pylint: Command not found
Makefile:24: recipe for target 'lint' failed
make: *** [lint] Error 127
```

1. Add `pylint==2.5.3` to requirements.txt
2. Also need to fix the syntax error detected by pylint in app.py as below


```
(.devops) ✔ ~/Dropbox/Udacity/DevOps/microservice_ci [master|✚ 1…1] 
02:04 $ make lint
# See local hadolint install instructions:   https://github.com/hadolint/hadolint
# This is linter for Dockerfiles
hadolint Dockerfile
# This is a linter for Python source code linter: https://www.pylint.org/
# This should be run from inside a virtualenv
pylint --disable=R,C,W1203 app.py
************* Module app
app.py:23:11: W1309: Using an f-string that does not have any interpolated variables (f-string-without-interpolation)

------------------------------------------------------------------
Your code has been rated at 9.66/10 (previous run: 8.28/10, +1.38)

make: *** [lint] Error 4
(.devops) ✘-2 ~/Dropbox/Udacity/DevOps/microservice_ci [master|✚ 1…1] 
02:04 $ make lint
# See local hadolint install instructions:   https://github.com/hadolint/hadolint
# This is linter for Dockerfiles
hadolint Dockerfile
# This is a linter for Python source code linter: https://www.pylint.org/
# This should be run from inside a virtualenv
pylint --disable=R,C,W1203 app.py

-------------------------------------------------------------------
Your code has been rated at 10.00/10 (previous run: 8.28/10, +1.72)

(.devops) ✔ ~/Dropbox/Udacity/DevOps/microservice_ci [master|✚ 2…1] 
```