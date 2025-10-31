#!/bin/bash

LONG=sideloaded:,rootless:,trollstore
OPTS=$(getopt -a weather --longoptions "$LONG" -- "$@")

while :; do
  case "$1" in
    --sideloaded)
      echo -e '\033[1m\033[32mBuilding BHTwitter project for sideloaded.\033[0m'

      make clean
      rm -rf .theos
      make SIDELOADED=1

      if [ $? -eq 0 ]; then
        echo -e '\033[1m\033[32mMake command succeeded.\033[0m'
      else
        echo -e '\033[1m\033[31mMake command failed.\033[0m'
        exit 1
      fi

      if [ -e ./packages/com.atebits.Tweetie2.ipa ]; then
        echo -e '\033[1m\033[32mBuilding the IPA.\033[0m'
        cyan -i packages/com.burbn.instagram.ipa -o packages/BHInstagram-sideloaded --ignore-encrypted \
          -uwf .theos/obj/debug/keychainfix.dylib .theos/obj/debug/BHInstagram.dylib layout/Library/Application\ Support/BHI/BHInstagram.bundle

        echo -e '\033[1m\033[32mDone, thanks for using BHInstagram.\033[0m'
      else
        echo -e '\033[1m\033[0;31mpackages/com.burbn.instagram.ipa not found.\033[0m'
      fi
      break
      ;;
    --rootless)
      echo -e '\033[1m\033[32mBuilding BHInstagram project for Rootless.\033[0m'

      make clean
      rm -rf .theos
      export THEOS_PACKAGE_SCHEME=rootless
      make package

      echo -e '\033[1m\033[32mDone, thanks for using BHInstagram.\033[0m'
      break
      ;;
    --trollstore)
      echo -e '\033[1m\033[32mBuilding BHInstagram project for TrollStore.\033[0m'

      make clean
      rm -rf .theos
      make

      if [ $? -eq 0 ]; then
        echo -e '\033[1m\033[32mMake command succeeded.\033[0m'
      else
        echo -e '\033[1m\033[31mMake command failed.\033[0m'
        exit 1
      fi

      if [ -e ./packages/com.atebits.Tweetie2.ipa ]; then
        echo -e '\033[1m\033[32mBuilding the IPA.\033[0m'

        cyan -i packages/com.burbn.instagram.ipa -o packages/BHInstagram-trollstore.tipa --ignore-encrypted \
          -uwf .theos/obj/debug/BHInstagram.dylib layout/Library/Application\ Support/BHI/BHInstagram.bundle

        echo -e '\033[1m\033[32mDone, thanks for using BHInstagram.\033[0m'
      else
        echo -e '\033[1m\033[0;31mpackages/com.burbn.instagram.ipa not found.\033[0m'
      fi
      break
      ;;
    *)
      echo -e '\033[1m\033[32mBuilding BHInstagram project for Rootfull.\033[0m'

      make clean
      rm -rf .theos
      unset THEOS_PACKAGE_SCHEME
      make package

      echo -e '\033[1m\033[32mDone, thanks for using BHInstagram.\033[0m'
      break
      ;;
  esac
done