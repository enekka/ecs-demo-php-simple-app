FROM public.ecr.aws/amazonlinux/amazonlinux:2

# Install dependencies
RUN yum install -y \
    curl \
    httpd \
    php \
 && ln -s /usr/sbin/httpd /usr/sbin/apache2

# Install app
RUN rm -rf /var/www/html/* && mkdir -p /var/www/html
ADD src /var/www/html

# Configure apache
RUN chgrp -R 0 /var/www
RUN chmod -R g=u /var/www
#ENV APACHE_RUN_USER apache
#ENV APACHE_RUN_GROUP apache
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

USER 1001

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
