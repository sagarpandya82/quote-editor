# Rails 7.0.0 compatible Ruby
FROM ruby:3.0.6

# Install system dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

# Install Node 18 (required for esbuild / Hotwire)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

# Set working directory
WORKDIR /app

# Ensure gem binaries are on PATH
ENV PATH="/usr/local/bundle/bin:${PATH}"

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install JS dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of the app
COPY . .

# Rails defaults
ENV RAILS_ENV=development
EXPOSE 3000

# Start Rails (no daemonisation)
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
