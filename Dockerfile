ARG VERSION=3.1.3
FROM ruby:${VERSION} AS base
RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
      squashfs-tools \
 && rm -rf /var/lib/apt/lists/*

FROM base AS build

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
      bison \
      ncurses-dev \
 && rm -rf /var/lib/apt/lists/*

ARG VERSION
RUN git clone --branch=$(echo $VERSION | sed 's/\./_/g') --single-branch \
      https://github.com/ericbeland/ruby-packer.git
WORKDIR /ruby-packer
RUN bundle install \
 && bundle exec rake rubyc

FROM base AS release
COPY --from=build /ruby-packer/rubyc /usr/local/bin/
