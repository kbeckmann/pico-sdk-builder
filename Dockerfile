FROM archlinux/archlinux

WORKDIR /opt

RUN echo 'Server = http://mirror.one.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
    yes | pacman -Syyu && \
    pacman --noconfirm -S base-devel wget sudo vi && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    chown docker:docker /opt && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo -u docker bash -c "\
        wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz && \
        tar xf yay-bin.tar.gz && \
        (cd yay-bin && yes | makepkg -s --skippgpcheck) && \
        (cd yay-bin && sudo pacman --noconfirm -U *.pkg.tar*) \
    "

USER docker

RUN yay --noconfirm -S arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-newlib
RUN yay --noconfirm -S cmake python3

# Download the pico-sdk
RUN git clone https://github.com/raspberrypi/pico-sdk

# We could use --recurse-submodules above, but we don't need _all_ the nested submodules
RUN cd pico-sdk && git submodule update --init

ENV PICO_SDK_PATH=/opt/pico-sdk

# Ready to build stuff
CMD /bin/bash
