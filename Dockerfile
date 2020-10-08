FROM alpine:latest
LABEL maintainer="Helppoelämä https://helppoelama.net"

RUN apk update && apk upgrade

RUN apk add fish && apk add curl && apk add nano && apk add sudo

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk
RUN apk add glibc-2.32-r0.apk

RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-bin-2.32-r0.apk
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-i18n-2.32-r0.apk
RUN apk add glibc-bin-2.32-r0.apk glibc-i18n-2.32-r0.apk

RUN /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8
RUN /usr/glibc-compat/bin/localedef -i fi_FI -f UTF-8 fi_FI.UTF-8

RUN rm -rf *.apk

ENV HOME /home/deno
ENV DENO_DIR $HOME/.deno
ENV PATH $DENO_DIR/bin:$PATH

RUN adduser --disabled-password -h $HOME -s /usr/bin/fish deno
RUN echo "deno:deno" | chpasswd
RUN su -l root
RUN echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
RUN adduser deno wheel
RUN adduser deno deno

RUN mkdir $HOME/app \
 && chown -R deno $HOME/app

USER deno

RUN curl -fsSL https://deno.land/x/install/install.sh | sh

COPY app/ $HOME/app/

EXPOSE 8000

WORKDIR $HOME/app

# Comment out ENTRYPOINT if you want to run deno straight with docker.
CMD ["deno", "run", "--allow-net", "server.js"]
#ENTRYPOINT ["/usr/bin/fish"]