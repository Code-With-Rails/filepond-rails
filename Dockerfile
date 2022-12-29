FROM ruby:3.2-bullseye

SHELL ["/bin/bash", "--login", "-c"]

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y   build-essential   nano   libvips
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN nvm install 18.12.1

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /filepond-rails
WORKDIR /filepond-rails

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY lib/filepond/rails/version.rb ./lib/filepond/rails/
COPY filepond-rails.gemspec ./
COPY Gemfile* ./
RUN gem install bundler -v 2.3.3 && bundle install --jobs 20 --retry 5

COPY . /filepond-rails
RUN rm -rf tmp/*

ADD . /filepond-rails
