#!/bin/bash
git reset --hard

git fetch -p && git pull

git switch release

ENV=$1
SERVICE=$2
TAG=$3

# Dir
ROOT_DIR=$(dirname $(realpath $0))

# Modify the version file based on service
case "$SERVICE" in
    "juicy")
        sed "s/JUICY=.*/JUICY=${TAG}/" ${ROOT_DIR}/version.${ENV} > ${ROOT_DIR}/version.${ENV}.tmp && mv ${ROOT_DIR}/version.${ENV}.tmp ${ROOT_DIR}/version.${ENV}
      ;;
      
    "so-zesty-jr")
        sed "s/ZESTY_SO=.*/ZESTY_SO=${TAG}/" ${ROOT_DIR}/version.${ENV} > ${ROOT_DIR}/version.${ENV}.tmp && mv ${ROOT_DIR}/version.${ENV}.tmp ${ROOT_DIR}/version.${ENV}
      ;;
    "so-zesty")
        sed "s/ZESTY_NGINX_SO=.*/ZESTY_NGINX_SO=${TAG}/" ${ROOT_DIR}/version.${ENV} > ${ROOT_DIR}/version.${ENV}.tmp && mv ${ROOT_DIR}/version.${ENV}.tmp ${ROOT_DIR}/version.${ENV}
      ;;
    "zesty")
        sed "s/ZESTY=.*/ZESTY=${TAG}/" ${ROOT_DIR}/version.${ENV} > ${ROOT_DIR}/version.${ENV}.tmp && mv ${ROOT_DIR}/version.${ENV}.tmp ${ROOT_DIR}/version.${ENV}
      ;;
    *)
      # Default case for unknown service names
      echo "Unknown service: $SERVICE"
      ;;
esac


# Push to github
git commit -am"chore: update $ENV $SERVICE to $TAG"

git push