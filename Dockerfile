FROM archlinux
# debian:stable-slim

ENV DOCKER_USR dav

LABEL org.opencontainers.image.description="davmail"

RUN pacman -Sy --nodeps --noconfirm glibc python-jinja \
    git fakeroot sudo binutils \
    && pacman -Scc --noconfirm

RUN useradd -ms /bin/bash $DOCKER_USR \
  && echo "$DOCKER_USR ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${DOCKER_USR}
WORKDIR /home/$DOCKER_USR

RUN git clone https://aur.archlinux.org/yay-bin.git \
    && cd yay-bin \
    && makepkg -si --noconfirm \
    && rm -rf /home/$DOCKER_USR/yay-bin \
    && yay -Sy --noconfirm davmail \
    && yay -Scc --noconfirm \
    && sudo pacman -Rs --noconfirm git fakeroot binutils yay

COPY --chown=root:root --chmod=0444 davmail.properties.j2 davmail.properties.j2
COPY --chown=root:root --chmod=0445 main.py main.py

CMD ["python", "main.py"]
