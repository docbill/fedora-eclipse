FROM fedora:24
MAINTAINER Bill C Riemers https://github.com/docbill

RUN dnf -y update && dnf -y install eclipse git eclipse-egit maven sudo PackageKit-gtk3-module libcanberra-gtk2 firefox tar bzip2 && dnf clean all

# Add the dockerfile to make rebuilds from the image easier
ADD Dockerfile /Dockerfile
ADD eclipse-wrapper /usr/bin/eclipse-wrapper

RUN chmod 555 /usr/bin/eclipse-wrapper

VOLUME /workspace
WORKDIR /workspace

ENTRYPOINT ["/usr/bin/eclipse-wrapper"]

