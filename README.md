# Rebase Script Repository

This repository contains shell scripts for rebasing a kernel. The main scripts are `rebase.sh` and `vars.sh`.

## Scripts

### rebase.sh

This script performs the rebasing. It takes in parameters for the OEM kernel link and branch, the CAF tag, and an optional commit hash. It then clones the OEM and CAF kernels, sets up the CAF kernel, and starts the rebasing process.

Usage: `bash work/rebase.sh "<oem_kernel_link -b oem_kernel_branch>" "<clo_tag>" "<optional: commit_hash>"`

### vars.sh

This script sets up some variables and git configurations. It is sourced by the `rebase.sh` script. This script sets the project directory, CLO repo link, and directory variables for OEM and CLO kernels. It also sets the git config for user name and email.

## How to Use

1. Clone this repository.
2. Run the `rebase.sh` script with the necessary parameters.

## Optional Parameters

The `rebase.sh` script takes an optional commit hash as the third parameter. If provided, the script will reset the CAF kernel to this commit before starting the rebasing process.

## Known Issues and Limitations

None at the moment.

## Contact

For any questions or issues, please contact the repository owner or maintainers.

Repository Owner: Carlo Dee
Email: carlodee.official@proton.me
