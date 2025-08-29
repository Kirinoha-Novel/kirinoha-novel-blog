# Reference: https://pablomarti.dev/deploy-zola-to-clouflare-workers/
#!/bin/sh

# Reference: https://please-sleep.cou929.nu/bash-strict-mode.html
set -eux

main() {
    # Replace config.toml
    rm -f config.toml
    cp -p prod.config.toml config.toml

    # Set Zola version
    ZOLA_VERSION=0.21.0

    # Install Zola
    echo "Installing Zola ${ZOLA_VERSION}..."
    if [ ! -e zola-v{$ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz ]; then
        # Download Zola
        curl -sLJO "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v{$ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    fi
    if [ ! -d "${HOME}/.local/zola" ]; then
        # Create zola directory
            mkdir "${HOME}/.local/zola"
        else
            # Clean Up zola Directory
            rm -rf "${HOME}/.local/zola"
            # Create zola Directory
            mkdir "${HOME}/.local/zola"
    fi
    # Extract Zola
    tar -C "${HOME}/.local/zola" -xf "zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    # Clean Up tar.gz File
    rm "zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    # Export PATH environment variable
    export PATH="${HOME}/.local/zola:${PATH}"

    # Build Blog
    echo "Building the site..."
    zola build
}

# Call main Function
main
