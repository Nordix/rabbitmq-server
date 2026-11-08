FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG OTP_VERSION

ENV ERLANG_PREFIX=/opt/erlang
ENV ELIXIR_PREFIX=/opt/elixir
ENV PATH=/opt/elixir/bin:/opt/erlang/bin:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    build-essential \
    ca-certificates \
    curl \
    git \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libncurses5-dev \
    libpng-dev \
    libssl-dev \
    libwxgtk3.0-gtk3-dev \
    m4 \
    make \
    perl \
    unixodbc-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    curl -fsSL "https://erlang.org/download/otp_src_${OTP_VERSION}.tar.gz" \
      -o /tmp/otp.tar.gz; \
    mkdir -p /tmp/otp-src; \
    tar -xzf /tmp/otp.tar.gz -C /tmp/otp-src --strip-components=1; \
    cd /tmp/otp-src; \
    ./configure --prefix="${ERLANG_PREFIX}"; \
    make -j"$(nproc)"; \
    make install; \
    rm -rf /tmp/otp-src /tmp/otp.tar.gz

RUN set -eux; \
    curl -fsSL \
      "https://github.com/elixir-lang/elixir/releases/download/v1.9.4/Precompiled.zip" \
      -o /tmp/elixir.zip; \
    mkdir -p "${ELIXIR_PREFIX}"; \
    unzip -q /tmp/elixir.zip -d "${ELIXIR_PREFIX}"; \
    rm /tmp/elixir.zip

RUN erl -noshell -eval 'io:format("OTP ~s~n", [erlang:system_info(otp_release)]), halt().' \
    && elixir --version

WORKDIR /workspace
