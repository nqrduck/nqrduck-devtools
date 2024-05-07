#!/bin/bash

cd ..

# Create a nqrduck venv
python3 -m venv venv
source venv/bin/activate

# This are installed in editable mode
REPOS_py=(
    "https://github.com/nqrduck/nqrduck"
    "https://github.com/nqrduck/nqrduck-spectrometer"
    "https://github.com/nqrduck/nqrduck-spectrometer-limenqr"
    "https://github.com/nqrduck/nqrduck-spectrometer-simulator"
    "https://github.com/nqrduck/nqr-blochsimulator"
    "https://github.com/nqrduck/nqrduck-measurement"
    "https://github.com/nqrduck/nqrduck-autotm"
    "https://github.com/nqrduck/nqrduck-broadband"
    "https://github.com/nqrduck/nqrduck-pulseprogrammer"
)

# These are only cloned
OTHER_REPOS=(
    "https://github.com/nqrduck/ATM"
    "https://github.com/nqrduck/LimeDriver"
    "https://github.com/nqrduck/nqrduckumentation"
)

for repo in "${REPOS_py[@]}"; do
    git clone "$repo"
    cd "$(basename "$repo")" || { echo "Failed to enter $(basename "$repo"), skipping..."; continue; }
    pip install -e .
    cd ..
done

for repo in "${OTHER_REPOS[@]}"; do
    git clone "$repo"
done

# Limedriver bindings  need to be installed seperately
git clone "https://github.com/nqrduck/LimeDriverBindings"
cd LimeDriverBindings || { echo "Failed to enter LimeDriverBindings, skipping..."; continue; }
git submodule init
git submodule update
pip install -e .
cd ..

echo "All repositories have been cloned and installed in editable mode."