FROM archlinux

ENV DOCKER_USR dav

LABEL org.opencontainers.image.description="davmail"

RUN pacman -Sy --noconfirm base base-devel git glibc\
    && pacman -Scc --noconfirm

RUN useradd -ms /bin/bash $DOCKER_USR \
  && echo "$DOCKER_USR ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${DOCKER_USR}

WORKDIR /home/$DOCKER_USR

RUN git clone https://aur.archlinux.org/yay-bin.git \
    && cd yay-bin \
    && makepkg -si --noconfirm \
    && rm -rf /home/$DOCKER_USR/yay-bin \
    && yay -Sy --noconfirm davmail python-jinja \
    && yay -Scc --noconfirm

COPY davmail.properties.j2 davmail.properties.j2
COPY main.py main.py

CMD ["python", "main.py"]
