#!/bin/bash
git reset --hard

git switch release

git fetch -p && git pull

ENV=$1
SERVICE=$2
TAG=$3

# Modify the ENV
case "$ENV" in
    "dev")
        ENV=".dev"
      ;;
      
    "stg")
        ENV=".staging"
      ;;
    "prod")
        ENV=""
      ;;
    *)
      # Default case for unknown env names
      echo "Unknown env: $ENV"
      exit 1
      ;;
esac

# Dir
ROOT_DIR=$(dirname $(realpath $0))

# Modify the version file based on service
case "$SERVICE" in
    "envoy")
        sed "s/ENVOY=.*/ENVOY=${TAG}/" ${ROOT_DIR}/version${ENV} > ${ROOT_DIR}/version${ENV}.tmp && mv ${ROOT_DIR}/version${ENV}.tmp ${ROOT_DIR}/version${ENV}
      ;;
    "juicy")
        sed "s/JUICY=.*/JUICY=${TAG}/" ${ROOT_DIR}/version${ENV} > ${ROOT_DIR}/version${ENV}.tmp && mv ${ROOT_DIR}/version${ENV}.tmp ${ROOT_DIR}/version${ENV}
      ;;
    "so-zesty-jr")
        sed "s/ZESTY_SO=.*/ZESTY_SO=${TAG}/" ${ROOT_DIR}/version${ENV} > ${ROOT_DIR}/version${ENV}.tmp && mv ${ROOT_DIR}/version${ENV}.tmp ${ROOT_DIR}/version${ENV}
      ;;
    "so-zesty")
        sed "s/ZESTY_NGINX_SO=.*/ZESTY_NGINX_SO=${TAG}/" ${ROOT_DIR}/version${ENV} > ${ROOT_DIR}/version${ENV}.tmp && mv ${ROOT_DIR}/version${ENV}.tmp ${ROOT_DIR}/version${ENV}
      ;;
    "zesty")
        sed "s/ZESTY=.*/ZESTY=${TAG}/" ${ROOT_DIR}/version${ENV} > ${ROOT_DIR}/version${ENV}.tmp && mv ${ROOT_DIR}/version${ENV}.tmp ${ROOT_DIR}/version${ENV}
      ;;
    *)
      # Default case for unknown service names
      echo "Unknown service: $SERVICE"
      exit 1
      ;;
esac


# Push to github
git add .

git commit -am"chore: update $ENV $SERVICE to $TAG"

git push