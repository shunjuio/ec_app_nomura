# [Choice] Ruby version: 2.7, 3.0, 3.1
ARG RUBY_VERSION=3.2.2
FROM ruby:${RUBY_VERSION}-bullseye

ENV BUNDLE_APP_CONFIG=/workspace/.bundle
ENV PATH /workspace/bin:$PATH

# Install nodejs, yarn
ARG NODE_VERSION=16
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g yarn

# Set locale as ja_JP.UTF-8
RUN apt-get update && apt-get install -y locales
RUN sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
  && locale-gen
ENV LANG ja_JP.UTF-8

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ARG BUNDLER_VERSION='2.3.13'
RUN gem install bundler -v ${BUNDLER_VERSION}

# Install heroku command
RUN curl https://cli-assets.heroku.com/install.sh | sh

# git入力補完ツールのinstall
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
RUN chmod a+x ~/.git-completion.bash
RUN echo "source ~/.git-completion.bash" >> ~/.bashrc
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
RUN chmod a+x ~/.git-prompt.sh
RUN echo "source ~/.git-prompt.sh" >> ~/.bashrc

WORKDIR /workspace
