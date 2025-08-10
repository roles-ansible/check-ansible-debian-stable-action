# hadolint ignore=DL3007
FROM debian:stable

LABEL "maintainer"="L3D <l3d@c3woc.de>"
LABEL "repository"="https://github.com/roles-ansible/check-ansible-debian-stable-action.git"
LABEL "homepage"="https://github.com/roles-ansible/check-ansible-debian-stable-action"

LABEL "com.github.actions.name"="check-ansible-debian-stable"
LABEL "com.github.actions.description"="Check ansible role or playbook with Debian stable"
LABEL "com.github.actions.icon"="aperture"
LABEL "com.github.actions.color"="green"

# hadolint ignore=DL3008,DL3013
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    apt-utils \
    python3-xyzservices \
    software-properties-common \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    python3-venv \
    python3-pip \
    git \
    systemd \
    locales \
    libffi-dev \
    libssl-dev \
    libyaml-dev \
    python3-setuptools \
    python3-yaml \
    software-properties-common \
    systemd-cron sudo iproute2 \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* \
      && python3 -m venv ansible

# hadolint ignore=DL3008,DL3013,SC1091
RUN . /ansible/bin/activate \
      && pip3 install --no-cache-dir setuptools \
      && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
      && pip3 install --no-cache-dir ansible \
      && ansible --version

# Fix potential UTF-8 errors
RUN locale-gen en_US.UTF-8

COPY ansible-docker.sh /ansible-docker.sh
ENTRYPOINT ["/ansible-docker.sh"]
