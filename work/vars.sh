#!/bin/bash

# Set project directory
PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Variables
CLO_REPO="https://git.codelinaro.org/clo/la/kernel"

# Directory variables
OEM_KERNEL_DIR="oem_kernel"
CLO_KERNEL_DIR="clo_kernel"

# Git config
git config --global user.name "Carlo Dee"
git config --global user.email "carlodee.official@proton.me"