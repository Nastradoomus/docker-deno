FROM ubuntu:groovy
MAINTAINER "Torgie <torgie@gmail.com>"

# Necessary installations required to install deno
RUN apt-get update && apt-get install -y \
      curl \
      unzip

# Deno environment variables
# See: https://deno.land/manual/getting_started/setup_your_environment
ENV HOME /home/deno
ENV DENO_DIR $HOME/.deno
ENV PATH $DENO_DIR/bin:$PATH

# Create the deno user and group, fixed to uid = gid = 1000
RUN addgroup -gid 1000 deno \
 && adduser --uid 1000 --gid 1000 --home $HOME --shell /bin/bash --disabled-password --gecos "" deno \
 && passwd -d deno

# Make a directory where deno scripts will live
RUN mkdir /app \
 && chown -R deno /app

# Become the deno user, and install deno as that user
USER deno

# Install and clean up the deno binary
RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.3.3

# Copy in the entrypoint script and set it
COPY examples/server.js /app/server.js
EXPOSE 8000

# Default command if no other command is given
WORKDIR /app
CMD ["deno", "run", "--allow-net", "server.js"]
