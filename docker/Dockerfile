FROM phusion/baseimage

ENV VSN master
ENV BUILD_DEPS "git make gcc wget erlang-dev erlang-parsetools elixir=1.4.5-1 npm"
ENV RELEASE_PATH /usr/lib/nemo

RUN curl -O https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y ${BUILD_DEPS} ${RUN_DEPS}

RUN mix local.hex --force && \
    mix local.rebar --force

RUN git clone https://github.com/onegrx/nemo.git --branch docker

ADD prod.secret.exs /nemo/config/prod.secret.exs
ADD prod.exs /nemo/config/prod.exs

RUN cd nemo && \
    mix deps.get && \
    MIX_ENV=prod mix compile && \
    npm install && ln -s /usr/bin/nodejs /usr/bin/node && \
    node_modules/brunch/bin/brunch build && \
    MIX_ENV=prod mix phoenix.digest && \
    MIX_ENV=prod mix release --env=prod


RUN mkdir ${RELEASE_PATH} && \
    tar xvf /nemo/rel/nemo/releases/*/nemo.tar.gz -C ${RELEASE_PATH} && \
    rm -rf /nemo erlang-solutions* && \
    apt-get purge -y --auto-remove $BUILD_DEPS

EXPOSE 80

ADD run.sh /run.sh

CMD ["bash", "/run.sh"]
