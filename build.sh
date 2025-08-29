# Reference: https://pablomarti.dev/deploy-zola-to-clouflare-workers/
#!/bin/sh

main() {
    # Set Zola version
    ZOLA_VERSION=0.21.0

    # Install Zola
    echo "Installing Zola ${ZOLA_VERSION}..."
    curl -sLJO "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v{$ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    mkdir "${HOME}/.local/zola"
    tar -C "${HOME}/.local/zola" -xf "zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    rm "zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    export PATH="${HOME}/.local/zola:${PATH}"

    # Build blog
    echo "Building the site..."
    zola build --minify
}

# Reference: https://please-sleep.cou929.nu/bash-strict-mode.html
set -euxo pipefail

# Call main function
main
