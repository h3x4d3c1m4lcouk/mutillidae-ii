# LEMP installation of Mutillidae II exposes port 80 and 443 however 443 needs additional work to enable certificates
FROM ubuntu:18.04
RUN apt-get update \
# Set noninteractive installation
    && export DEBIAN_FRONTEND=noninteractive \
# install tzdata package which is a dependency and set the timezone to prevent prompting
    && apt-get install -y tzdata \
# set your timezone here
    && ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
# Install the database server
    && apt-get install -y --no-install-recommends mysql-server \
# Install Nginx web server
    && apt-get install -y --no-install-recommends nginx \
# Install php and php requirements
    && apt-get install -y --no-install-recommends php7.2-fpm php7.2-curl php7.2-mbstring php7.2-xml  php-mysql \
# Install Git so we can clone the repository
    && apt-get install -y git \
# Optional installation of vim
    && apt-get install -y --no-install-recommends vim \
# Clean up apt packages
    && rm -rf /var/lib/apt/lists/* \
# Remove the default nginx site
    && rm -rf /etc/nginx/sites-enabled/default \
    && rm -rf /etc/nginx/sites-available/default 
# Create a working directory & copy the configuration files to it
WORKDIR /code
ADD ["."," /code"]
COPY ["resetdb.sql","/code/"]
# Copy the new default nginx configuration file, link it to sites-enabled and remove default html contents
COPY ["default","/etc/nginx/sites-available/"]
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
    && rm -rf /var/www/html/* \
# Clone Muttillidae II to the html directory
    && git clone https://github.com/webpwnized/mutillidae.git /var/www/html/ 
# Set bash entry point used when starting the container, and run the startup script to reset the root password if not already done and start nginx  php.
COPY ["startup.sh","/code/startup.sh"]
RUN chmod +x /code/startup.sh
WORKDIR /code
ENTRYPOINT /code/startup.sh && bash
# Set the label and version for the container
LABEL Name=mutillidae-ii Version=0.0.1
# Expose http and https (Note https not currently configured in this container)
EXPOSE 80/tcp
EXPOSE 443/tcp
