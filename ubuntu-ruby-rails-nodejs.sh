FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    nodejs \
    npm \
    tzdata

# Install Ruby
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y \
    ruby-full \
    ruby-dev \
    zlib1g-dev

# Install Rails
RUN gem install rails -v 6.0.4

# Install Node.js
RUN npm install -g n && n 14.15.1

# Set timezone
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo "UTC" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install project dependencies
RUN bundle install

# Expose port 3000
EXPOSE 3000

# Start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
