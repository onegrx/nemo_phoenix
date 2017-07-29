FROM phusion/baseimage

ENV VSN=master \
    BUILD_DEPS="git make gcc wget erlang-dev erlang-parsetools elixir=1.4.5-1 npm" \
    RELEASE_PATH=/usr/lib/nemo

ADD prod.secret.exs /prod.secret.exs
ADD prod.exs /prod.exs

RUN curl -O https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y ${BUILD_DEPS} ${RUN_DEPS} && \
    mix local.hex --force && \
    mix local.rebar --force && \
    git clone https://github.com/onegrx/nemo.git --branch ${VSN} && \
    mv /prod.secret.exs /nemo/config/prod.secret.exs && \
    mv /prod.exs /nemo/config/prod.exs && \
    cd nemo && \
    mix deps.get && \
    MIX_ENV=prod mix compile && \
    npm install && ln -s /usr/bin/nodejs /usr/bin/node && \
    node_modules/brunch/bin/brunch build && \
    MIX_ENV=prod mix phoenix.digest && \
    MIX_ENV=prod mix release --env=prod && \
    mkdir ${RELEASE_PATH} && \
    tar xvf /nemo/rel/nemo/releases/*/nemo.tar.gz -C ${RELEASE_PATH} && \
    rm -rf /nemo erlang-solutions* && \
    apt-get purge -y --auto-remove $BUILD_DEPS

EXPOSE 80

ADD run.sh /run.sh

CMD ["bash", "/run.sh"]
