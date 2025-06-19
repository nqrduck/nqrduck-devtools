#!/bin/bash

cd ..

# Create a nqrduck venv
python3 -m venv venv
source venv/bin/activate

# Theses are installed in editable mode
REPOS_py=(
    "ssh://git@git.private.coffee/nqrduck/nqrduck.git"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-spectrometer"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-spectrometer-limenqr"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-spectrometer-simulator"
    "ssh://git@git.private.coffee/nqrduck/nqr-blochsimulator"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-measurement"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-autotm"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-broadband"
    "ssh://git@git.private.coffee/nqrduck/nqrduck-pulseprogrammer"
    "ssh://git@git.private.coffee/nqrduck/quackseq"
    "ssh://git@git.private.coffee/nqrduck/quackseq-simulator"
    "ssh://git@git.private.coffee/nqrduck/quackseq-limenqr"
)

# These are only cloned
OTHER_REPOS=(
    "ssh://git@git.private.coffee/nqrduck/ATM"
    "ssh://git@git.private.coffee/nqrduck/LimeDriver"
    "ssh://git@git.private.coffeenqrduck/nqrduckumentation"
)

for repo in "${REPOS_py[@]}"; do
    git clone "$repo"
    cd "$(basename "$repo")" || { echo "Failed to enter $(basename "$repo"), skipping..."; continue; }
    pip install -e .
    git checkout development
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
git clone "ssh://git@git.private.coffee/nqrduck/LimeDriverBindings"
cd LimeDriverBindings || { echo "Failed to enter LimeDriverBindings, skipping..."; continue; }
git submodule init
git submodule update
pip install -e .
cd ..

echo "All repositories have been cloned and installed in editable mode."