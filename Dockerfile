FROM centos:7
MAINTAINER Tobias Florek tob@butter.sh

EXPOSE 24 143 993 110 995

RUN set -x \
 && rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
 && yum --setopt=tsflags=nodocs -y install \
        dovecot dovecot-pigeonhole openldap-clients \
 && yum clean all \
 && useradd -U vmail

CMD ["/usr/sbin/dovecot", "-F"]

VOLUME ["/etc/dovecot", "/var/mail"]
