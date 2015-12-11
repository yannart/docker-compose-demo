FROM httpd:2.2

# Copy the static files.
COPY ./htdocs/* /usr/local/apache2/htdocs/

# Copy the Apache modules.
COPY ./modules/* /usr/local/apache2/modules/

# Copy the configuration files.
COPY ./conf/* /usr/local/apache2/conf/
