## Create a Mutillidae II LEMP (Linux Nginx Mysql PHP) docker container image on Ubuntu 18:04

A great platform for learning web security. The Official repo for Mutillidae can be found at https://github.com/webpwnized/mutillidae 

For details please see my blog at https://www.h3x4d3c1m4l.co.uk/projects/Mutillidae-II-LEMP

The whole process only takes a minute or two to get an instance of Mutillidae II up and running locally and you can build as many as you like with only a few minor changes. They are easy to destroy and re-create and pull from official sources. 

### Docker & Clone
If you are not familiar with docker please have a look at my quick start guide here https://www.h3x4d3c1m4l.co.uk/projects/docker. 

To start, take a git clone of the files to a local directory.

### Build
The build command is as follows and needs to be run from within the same folder as the Dockerfile. Don't forget the dot at the end!

    $ docker build --rm -f "Dockerfile" -t mutillidae-ii:latest .

Once the build is complete to run, with a persistent database and a working directory /code use the following which maps host port 8888 to the container port 80. 

### Run

    $ docker run -p 127.0.0.1:8888:80 -p 127.0.0.1:444:443 --rm -d --name mutillidae-ii -v mutillidae-ii-data:/var/lib/mysql -v mutillidae-ii-code:/code mutillidae-ii:latest

On the local machine you should now be able to browse to http://localhost:8888
    
NOTE: Be careful with 'force SSL' in the application without configuring SSL first and making sure it is working as Chrome (and possibly others) seems to always redirect to SSL on localhost:8888 once enabled! 

### Shell
To connect to the running image with a bash shell

    $ docker exec -it nnnn bash      # Where nnnn is the docker image container id reference

Also runs on Windows configured to run linux docker images!
NOTE: This will also run as a Linux container under Windows. CR LF have been removed from these files which would normally cause a script not found error.

### More Details

Dockerfile - This is the main file that builds the container using an official image from Ubuntu. It then performs the various installations using apt. 

resetdb.sql - this resets the database username and password used by Mutillidae in the correct format. 

startup.sh - For the first run this will create the database and then subsequently starts MySQL, PHP and Nginx every launch.

On a Linux docker instance the persistent database files are stored in docker volumes. On the host these will typically be in /var/lib/docker/volumes/



