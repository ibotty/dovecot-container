FROM quay.io/centos/centos:centos8
LABEL MAINTAINER="Tobias Florek tob@butter.sh"

EXPOSE 24 143 993 110 995

ADD dovecot-23.repo /etc/yum.repos.d/
ADD DOVECOT-REPO-GPG /etc/pki/rpm-gpg/

RUN set -x \
 && rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial \
 && rpmkeys --import /etc/pki/rpm-gpg/DOVECOT-REPO-GPG \
 && dnf --setopt=tsflags=nodocs -y install \
        dovecot dovecot-pigeonhole openldap-clients \
 && yum clean all \
 && useradd -U vmail

CMD ["/usr/sbin/dovecot", "-F"]

VOLUME ["/etc/dovecot", "/var/mail"]
