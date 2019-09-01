FROM elixir:1.9.1

RUN mix local.hex --force
RUN apt-get update
RUN apt-get install -y apt-utils 
RUN apt-get install -y build-essential
RUN apt-get install -y inotify-tools
# RUN apt-get install curl
# RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.4.9
# RUN apt-get install -y nodejs

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

EXPOSE 4000


CMD mix deps.get && mix ecto.create && mix ecto.migrate && mix phx.server