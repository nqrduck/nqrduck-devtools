#!/bin/bash

REPOS=(
    "nqrduck"
    "nqrduck-spectrometer"
    "nqrduck-spectrometer-limenqr"
    "nqrduck-spectrometer-simulator"
    "ATM"
    "nqr-blochsimulator"
    "nqrduck-measurement"
    "nqrduck-autotm"
    "nqrduck-broadband"
    "nqrduck-pulseprogrammer"
    "LimeDriverBindings"
    "LimeDriver"
    "nqrduckumentation"
    "quackseq"
    "quackseq-simulator"
    "quackseq-limenqr"
)

# Pull the current repository
echo "Pulling changes in nqrduck-devtools..."
git pull

cd ..

# Iterate through the repositories and run git pull on each one
for repo in "${REPOS[@]}"; do
    echo "Pulling changes in $repo..."
    cd "$repo" || { echo "Failed to enter $repo, skipping..."; continue; }

    if [ ! -d ".git" ]; then
        echo "This directory doesn't seem to be a git repository: $repo"
        continue
    fi

    git pull
    echo "Done pulling $repo."
    cd ..
done

echo "All repositories have been updated."
