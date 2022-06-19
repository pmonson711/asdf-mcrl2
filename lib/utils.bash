#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/mcrl2org/mcrl2"
TOOL_NAME="mcrl2"
TOOL_TEST="mcrl22lps --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/mcrl2-.*' | cut -d/ -f3- |
    sed 's/^mcrl2-//'
}

list_all_versions() {
  list_github_tags
}

determine_release_file() {
  local download_path install_version
  download_path="$1"
  install_version="$2"

  if command -v dpkg &>/dev/null; then
    echo "${download_path}/$TOOL_NAME-${install_version}_x86_64.deb"
  elif command -v sw_vers &>/dev/null; then
    echo "${download_path}/$TOOL_NAME-${install_version}_x86_64.dmg"
  else
    fail "currently only dpkg based installs are supported"
  fi
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  if command -v dpkg &>/dev/null; then
    url="$GH_REPO/releases/download/mcrl2-${version}/mcrl2-${version}_x86_64.deb"
  elif command -v sw_vers &>/dev/null; then
    url="$GH_REPO/releases/download/mcrl2-${version}/mcrl2-${version}_x86_64.dmg"
  else
    fail "currently only dpkg based installs are supported"
  fi

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

extract_release() {
  local release_file download_path
  release_file="$1"
  download_path="$2"

  if command -v dpkg &>/dev/null; then
    dpkg -x "$release_file" "$download_path" || fail "Could not extract $release_file"
  elif command -v sw_vers &>/dev/null; then
    7z x "$release_file" -o"$download_path"
    ls -al "${download_path}/mcrl2-202106.0.54fa1483c9M_x86_64/mCRL2.app/Contents"
    tree "${download_path}/mcrl2-202106.0.54fa1483c9M_x86_64/mCRL2.app/Contents"
  else
    fail "currently only dpkg based installs are supported"
  fi
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/usr/bin/$tool_cmd" || fail "Expected $install_path/usr/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
