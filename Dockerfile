FROM ruby:3.0.1
ENV LANG C.UTF-8
ENV TZ=Asia/Tokyo

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn 

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock

RUN bundle install
ADD . $APP_HOME


# FROM ruby:2.6.5

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev imagemagick vim cron

# RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
#     curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#     echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
#     apt-get update && apt-get install -y yarn default-mysql-client
# # Node.jsをインストール
# RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
#     apt-get install nodejs
# ENV LANG C.UTF-8
# RUN mkdir /app
# WORKDIR /app
# ADD Gemfile /app/Gemfile
# ADD Gemfile.lock /app/Gemfile.lock
# RUN bundle install -j4
# ADD . /app

# RUN bundle exec whenever --update-crontab
# CMD ["cron", "-f"]

# RUN yarn install

# FROM ruby:2.6.5
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# RUN mkdir /myapp
# WORKDIR /myapp
# COPY Gemfile /myapp/Gemfile
# COPY Gemfile.lock /myapp/Gemfile.lock
# RUN bundle install
# COPY . /myapp

# # Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# # Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]