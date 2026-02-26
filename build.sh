#!/usr/bin/env bash

# Build Hugo site on Cloudflare with the same toolchain and flags as GitHub Actions.
set -euo pipefail

main() {
  DART_SASS_VERSION="${DART_SASS_VERSION:-1.96.0}"
  GO_VERSION="${GO_VERSION:-1.25.5}"
  HUGO_VERSION="${HUGO_VERSION:-0.153.1}"
  NODE_VERSION="${NODE_VERSION:-24.12.0}"
  export TZ="${TZ:-Europe/Oslo}"

  mkdir -p "${HOME}/.local"

  echo "Installing Dart Sass ${DART_SASS_VERSION}..."
  curl -fsSLO "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  tar -C "${HOME}/.local" -xf "dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  rm -f "dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  export PATH="${HOME}/.local/dart-sass:${PATH}"

  echo "Installing Go ${GO_VERSION}..."
  curl -fsSLO "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
  rm -rf "${HOME}/.local/go"
  tar -C "${HOME}/.local" -xf "go${GO_VERSION}.linux-amd64.tar.gz"
  rm -f "go${GO_VERSION}.linux-amd64.tar.gz"
  export PATH="${HOME}/.local/go/bin:${PATH}"

  echo "Installing Hugo ${HUGO_VERSION}..."
  curl -fsSLO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_withdeploy_${HUGO_VERSION}_linux-amd64.tar.gz"
  rm -rf "${HOME}/.local/hugo"
  mkdir -p "${HOME}/.local/hugo"
  tar -C "${HOME}/.local/hugo" -xf "hugo_extended_withdeploy_${HUGO_VERSION}_linux-amd64.tar.gz"
  rm -f "hugo_extended_withdeploy_${HUGO_VERSION}_linux-amd64.tar.gz"
  export PATH="${HOME}/.local/hugo:${PATH}"

  echo "Installing Node.js ${NODE_VERSION}..."
  curl -fsSLO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz"
  rm -rf "${HOME}/.local/node-v${NODE_VERSION}-linux-x64"
  tar -C "${HOME}/.local" -xf "node-v${NODE_VERSION}-linux-x64.tar.xz"
  rm -f "node-v${NODE_VERSION}-linux-x64.tar.xz"
  export PATH="${HOME}/.local/node-v${NODE_VERSION}-linux-x64/bin:${PATH}"

  echo "Verifying installations..."
  echo "Dart Sass: $(sass --version)"
  echo "Go: $(go version)"
  echo "Hugo: $(hugo version)"
  echo "Node.js: $(node --version)"

  echo "Configuring Git..."
  git config core.quotepath false
  if [ "$(git rev-parse --is-shallow-repository 2>/dev/null || echo false)" = "true" ]; then
    git fetch --unshallow
  fi
  git submodule update --init --recursive

  if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then
    echo "Installing Node.js dependencies..."
    npm ci
  fi

  echo "Building site..."
  base_url="${CF_PAGES_URL:-}"
  if [ -n "${base_url}" ]; then
    hugo --gc --minify --baseURL "${base_url%/}/" --cacheDir "${HOME}/.cache/hugo"
  else
    hugo --gc --minify --cacheDir "${HOME}/.cache/hugo"
  fi
}

main "$@"
