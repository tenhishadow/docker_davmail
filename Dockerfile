FROM archlinux
ENV DOCKER_USR dav

LABEL org.opencontainers.image.description="davmail"

RUN pacman -Sy --noconfirm base base-devel git \
    && pacman -Scc --noconfirm

RUN useradd -ms /bin/bash $DOCKER_USR \
  && echo "$DOCKER_USR ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${DOCKER_USR}

WORKDIR /home/$DOCKER_USR

RUN git clone https://aur.archlinux.org/yay-bin.git \
    && cd yay-bin \
    && makepkg -si --noconfirm \
    && rm -rf ./yay-bin \
    && yay -Sy --noconfirm davmail \
    && yay -Scc --noconfirm
