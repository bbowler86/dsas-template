## Data Science and Analytics Society (DSAS) <br /> @Baruch College <br /> Project Template for Reproducible Research

#### Motivation:
This project is intended to help understand how to create reproducible research within the realm of Data Science and Analytics. The importance of creating reproducible research is to show the intended audience how the data was cleaned, transformed, and analyzed in a way that they are able to reproduce the results on their own machine.

We will focus on doing research through Python but the same concepts can be applied when running any language. The Python packages `virtualenv` and `conda`) could be used to create virtual environments but that will often leave system level dependencies which may vary from system to system. This project will help overcome those shortcomings by creating an ubuntu container with Docker and installing Jupyter Labs.

#### Requirements:
The following items are needed in order to run this project:
* [Docker Community Edition](https://hub.docker.com/search/?type=edition&offering=community)
* [git](https://git-scm.com/downloads)
* [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) shell
	* Terminal.app for OSX
	* WSL for Windows 10

#### Running:
The following commands may vary depending on where you cloned this repository. I have a directory named `git` in my home directory, so I run the following commands to clone and enter the newly created directory:

```
cd ~/git
git clone <url> template
cd template
```
From there run the following command to build the image:
```
docker build . -t ubuntu:dsas
```
The command above will look for the file `Dockerfile` in the current directory and will build the `ubuntu:dsas` Docker image. The flag `-t` is the same as the flag `--tag` and allows you to name your images in a way that when you go to instantiate your images you can use that name rather than the ID of the image.

```
docker run -it -p 8888:8888 -v $(pwd):/analysis ubuntu:dsas /bin/bash
```
The `docker run` command above will start the docker container and your command prompt terminal should now start with `(dsas)` to indicate to you that you are now not only inside of the container but also within the conda environment `dsas`.

The first thing you should do once inside your container is setup a password. 
```
jupyter notebook password
```
Then after that you can start the application Jupyter Lab by running the following command:
```
jupyter lab --allow-root --ip=0.0.0.0 --no-browser
```
Open up a web browser and navigate to `127.0.0.1:8888`. From there enter in your password that you created and hit enter. You are now successfully in Jupyter Lab.
