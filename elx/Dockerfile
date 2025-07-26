# === Stage 1: Build ===
FROM hexpm/elixir:1.16.1-erlang-26.2.5-alpine-3.18 AS build

# Install build dependencies
RUN apk add --no-cache build-base git npm nodejs python3

# Set environment
ENV MIX_ENV=prod
WORKDIR /app

# Install Hex & Rebar
RUN mix local.hex --force && mix local.rebar --force

# Copy and compile dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod && mix deps.compile

# Copy the rest of the app
COPY . .

# Compile assets if you use Phoenix static assets
RUN npm --prefix assets install && npm --prefix assets run deploy
RUN mix phx.digest

# Build the release
RUN mix release

# === Stage 2: Production ===
FROM alpine:3.18 AS app

RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/elx ./

ENV REPLACE_OS_VARS=true \
    MIX_ENV=prod \
    PHX_SERVER=true \
    PORT=4000

EXPOSE 4000

CMD ["bin/elx", "start"]
