FROM archlinux:base-devel

MAINTAINER Jon Packard <jon@packard.tech>
#Credit to https://github.com/choldrim/docker-distcc for the entrypoint.sh script.

RUN pacman --noconfirm --needed -Syu distcc gcc clang git base-devel \
    && rm -rf /var/cache/pacman/pkg/*

RUN useradd -m build \
    && su -lc "git clone https://aur.archlinux.org/distccd-alarm.git" build \
    && su -lc "cd /home/build/distccd-alarm && makepkg --noconfirm --skippgpcheck" build \
    && pacman --noconfirm -U /home/build/distccd-alarm/*.zst \
    && rm -rf /home/build/*

COPY entrypoint.sh /entrypoint.sh

EXPOSE 3632
EXPOSE 3633
EXPOSE 3634
EXPOSE 3635
EXPOSE 3636

ENTRYPOINT ["/entrypoint.sh"]

#docker run -d -e NETWORK=10.0.0.1/16 -e JOBS=4 -p 3632:3632 -p 3633:3633 -p 3634:3634 -p 3635:3635 -p 3636:3636 --user distcc al-distcc-server-armcross
