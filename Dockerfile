FROM bitnami/minideb:jessie
MAINTAINER "Jon Davis" <jon@snowulf.com>
EXPOSE 6379

# VARIABLES
ENV DIRECTORY "/home/hubot"
ENV NAME "debtcat"
ENV OWNER "Debt Owner"
ENV DESCRIPTION "Debt Description"
ENV NODE_VERSION "6.11.2"

# INSTALL SYSTEM TOOLS
RUN install_packages sudo autoconf build-essential ca-certificates curl git-core redis-server

# USER MANAGEMENT FOR APP
RUN useradd -d "$DIRECTORY" -ms /bin/bash hubot
RUN echo "hubot ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR "$DIRECTORY"
USER hubot

# DOWNLOAD NODENV AND PATH
RUN git clone git://github.com/OiNutter/nodenv.git /home/hubot/.nodenv && \
git clone git://github.com/OiNutter/node-build.git /home/hubot/.nodenv/plugins/node-build
ENV PATH /home/hubot/.nodenv/shims:/home/hubot/.nodenv/bin:/home/hubot/.nodenv/versions/$NODE_VERSION/bin:$PATH

# INSTALL NODENV VERSION
RUN nodenv install "$NODE_VERSION"
RUN nodenv global "$NODE_VERSION"
RUN nodenv rehash

# CREATE HUBOT BASE
RUN npm config set unsafe-perm true
RUN npm cache clean && npm install -g yo
ADD conf/ "$DIRECTORY"
RUN npm install generator-hubot

# INSTALL APP
RUN yo hubot --owner="$OWNER" --name="$NAME" --description="$DESCRIPTION" --defaults

# STARTING APP AND SERVICES
ADD go.sh "$DIRECTORY"
RUN chmod +x "$DIRECTORY"/go.sh

# START EVERYTHING AND WATCHING LOGS
CMD bash /home/hubot/go.sh
