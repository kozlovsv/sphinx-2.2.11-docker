# Docker Image For Sphinx Search 2.2.11
# About
The image is based on the CentOS 7 operating system. It includes the Sphinx Search engine (version 2.2.11) pre-installed for legacy projects. 
The `sphinx.conf.template` file must be mounted to the `/etc/sphinx` directory within the container.
This is a standard `sphinx.conf` file, except that the database connection details have been replaced with values ​​from the `.env` file.
The variables in `sphinx.conf.template` that will be replaced with data from the `.env` file are:

* DB_HOST - MySQL database host
* DB_NAME - MySQL database name
* DB_USERNAME - MySQL database username
* DB_PASSWORD - MySQL database password

Upon startup, the `entrypoint.sh` script replaces these variables in the file and renames it to `sphinx.conf`; therefore, there is no point in mounting your own `sphinx.conf` file, as it will be overwritten.

**Directories**

* `/etc/sphinx` - configuration
* `/var/lib/sphinx` - data

