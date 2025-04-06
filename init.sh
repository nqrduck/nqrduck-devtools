#!/bin/bash

cd ..

# Create a nqrduck venv
python3 -m venv venv
source venv/bin/activate

# This are installed in editable mode
REPOS_py=(
    "https://git.private.coffee/nqrduck/nqrduck"
    "https://git.private.coffee/nqrduck/nqrduck-spectrometer"
    "https://git.private.coffee/nqrduck/nqrduck-spectrometer-limenqr"
    "https://git.private.coffee/nqrduck/nqrduck-spectrometer-simulator"
    "https://git.private.coffee/nqrduck/nqr-blochsimulator"
    "https://git.private.coffee/nqrduck/nqrduck-measurement"
    "https://git.private.coffee/nqrduck/nqrduck-autotm"
    "https://git.private.coffee/nqrduck/nqrduck-broadband"
    "https://git.private.coffee/nqrduck/nqrduck-pulseprogrammer"
    "https://git.private.coffee/nqrduck/quackseq"
    "https://git.private.coffee/nqrduck/quackseq-simulator"
    "https://git.private.coffee/nqrduck/quackseq-limenqr"
)

# These are only cloned
OTHER_REPOS=(
    "https://git.private.coffee/nqrduck/ATM"
    "https://git.private.coffee/nqrduck/LimeDriver"
    "https://git.private.coffeenqrduck/nqrduckumentation"
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

# Install the nqrduckumentation requirements
cd nqrduckumentation
pip install -r requirements.txt
cd ..

# Limedriver bindings  need to be installed seperately
git clone "https://github.com/nqrduck/LimeDriverBindings"
cd LimeDriverBindings || { echo "Failed to enter LimeDriverBindings, skipping..."; continue; }
git submodule init
git submodule update
pip install -e .
cd ..

echo "All repositories have been cloned and installed in editable mode."