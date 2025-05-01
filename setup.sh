#!/bin/bash
REPO_URL="https://github.com/zrsx/REQM"
LIB_DIR="$PREFIX/lib/python 3.12/site-packages/mreq"
PYTHON_DIR="./python/mreq"
INSTALL_DIR="$PREFIX/lib/python 3.12/site-packages/mreq"
JSON_DIR="./libs/json"

check_dependencies() {
command -v git >/dev/null 2>&1 || { echo "git is required but not installed. Exiting."; exit 1; }
command -v curl >/dev/null 2>&1 || { echo "curl is required but not installed. Exiting."; exit 1; }
}

clone_repo() {
[ ! -d "$PYTHON_DIR" ] && git clone "$REPO_URL" "$PYTHON_DIR"
}

download_libraries() {
mkdir -p "$LIB_DIR"
curl -L "$REPO_URL/releases/download/v1.0.0/libmreq.so" -o "$LIB_DIR/libmreq.so"
curl -L "$REPO_URL/releases/download/v1.0.0/libmreq.dylib" -o "$LIB_DIR/libmreq.dylib"
curl -L "$REPO_URL/releases/download/v1.0.0/libmreq.dll" -o "$LIB_DIR/libmreq.dll"
mkdir -p "$JSON_DIR"
curl -L "https://github.com/nlohmann/json/releases/download/v3.10.5/json.hpp" -o "$JSON_DIR/json.hpp"
}

install_package() {
#cd "$PYTHON_DIR" || exit
cp ./python/__init__.py "$INSTALL_DIR"
}

clean_up() {
rm -rf "$PYTHON_DIR"
rm -rf "$LIB_DIR"
}

main() {
check_dependencies
clone_repo
download_libraries
install_package
clean_up
echo "Installation complete."
}

main
