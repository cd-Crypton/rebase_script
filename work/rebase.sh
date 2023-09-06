#!/bin/bash

# Set project directory
PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

source ${PROJECT_DIR}/vars.sh

if [ -z "${1}" ] && [ -z "${2}" ]; then
     echo "Usage: bash work/rebase.sh \"<oem_kernel_link -b oem_kernel_branch>\" \"<clo_tag>\" \"<optional: commit_hash>\"
     >> eg: bash work/rebase.sh \"https://github.com/realme-kernel-opensource/realme_9i_9-4G-AndroidT-kernel-source -b master\" \"LA.UM.9.15.2.r1-07400-KAMORTA.QSSI12.0\" \"51e05ee99d0588939305de8f985a5f28c5bbaf65\""
     exit 1
else
     # Clone the OEM Kernel Source
     cd ${PROJECT_DIR}
     if [ ! -d "${OEM_KERNEL_DIR}" ]; then
          git clone --depth=1 --single-branch ${1} ${OEM_KERNEL_DIR}
     fi
     # Get Kernel Version
     KERNEL_VERSION="$(cat ${OEM_KERNEL_DIR}/Makefile | grep VERSION | head -n 1 | sed "s|.*=||1" | sed "s| ||g" )"
     KERNEL_SUBVERSION="$(cat ${OEM_KERNEL_DIR}/Makefile | grep PATCHLEVEL | head -n 1 | sed "s|.*=||1" | sed "s| ||g" )"
     CLO_REPO_FULL="${CLO_REPO}/msm-${KERNEL_VERSION}.${KERNEL_SUBVERSION}.git"
     
     # Clone the CAF Kernel Source
     if [ ! -d "${CLO_KERNEL_DIR}" ]; then
          git clone --single-branch ${CLO_REPO_FULL} -b ${2} ${CLO_KERNEL_DIR}
     fi
     cd "${OEM_KERNEL_DIR}"
     OEM_DIR_LIST=$(find -type d -printf "%P\n" | grep -v / | grep -v .git)
     cd ..
     if [ -z "${3}" ]; then
          # Set up CLO Kernel
          cd ${CLO_KERNEL_DIR}
          git switch -c ${2}
          # Start Rebasing
          cd ${PROJECT_DIR}
          cp -rf ${OEM_KERNEL_DIR}/* ${CLO_KERNEL_DIR}/
          cd ${CLO_KERNEL_DIR}
          git add .
          git commit -s -m "Import all OEM source modifications.
Rebased with ${2}."
     else
          # Start Rebasing
          cd ${CLO_KERNEL_DIR}
          git reset --hard ${3}
          git switch -c ${2}
          # Start Rebasing
          cd ${PROJECT_DIR}
          cp -rf ${OEM_KERNEL_DIR}/* ${CLO_KERNEL_DIR}/
          cd ${CLO_KERNEL_DIR}
          git add .
          git commit -s -m "Import all OEM source modifications.
Rebased with ${2}."
     fi
fi