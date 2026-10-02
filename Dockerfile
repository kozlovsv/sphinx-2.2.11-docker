FROM centos:7

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# CentOS 7 EOL: переключаем репозитории на vault
RUN sed -i \
        -e 's|mirrorlist=|#mirrorlist=|g' \
        -e 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' \
        /etc/yum.repos.d/CentOS-*.repo \
    && yum clean all \
    && yum makecache

# Зависимости Sphinx RPM
RUN yum install -y \
        wget \
        ca-certificates \
        gettext \
        postgresql-libs \
        unixODBC \
    && yum clean all \
    && rm -rf /var/cache/yum

# Sphinx 2.2.11
RUN wget -O /tmp/sphinx.rpm \
        https://sphinxsearch.com/files/sphinx-2.2.11-1.rhel7.x86_64.rpm \
    && yum install -y /tmp/sphinx.rpm \
    && rm -f /tmp/sphinx.rpm \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN mkdir -p \
        /var/lib/sphinx \
        /var/log/sphinx \
        /var/run/sphinx

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9312
EXPOSE 9306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["searchd", "--nodetach"]