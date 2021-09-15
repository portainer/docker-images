#!/bin/sh
set -e

: ${REPO:=$1/kubectl-shell}
: ${KUBERNETES_RELEASE:=v1.21.1}
: ${TAG:=$2}

docker_image_build_and_push()
{
  docker buildx build -o type=docker \
    --build-arg ARCH=${1?required} \
    --build-arg ALPINE=${2?required} \
    --build-arg KUBERNETES_RELEASE=${4?required} \
    --platform linux/${1} \
    --tag ${5?required}:${3}-${4}-${1} \
  ${6?required}
  docker image push ${5?required}:${3}-${4}-${1}
}

docker_manifest_create_and_push()
{
  images=$(docker image ls $1-* --format '{{.Repository}}:{{.Tag}}')
  docker manifest create --amend ${2?required} $images
  for img in $images; do
    docker manifest annotate $2 $1-${img##*-} --os linux --arch ${img##*-}
  done
  docker manifest push $2
}

docker_image_build_and_push amd64  amd64/alpine:latest   ${TAG} ${KUBERNETES_RELEASE} ${REPO} $(dirname $0)/.
docker_image_build_and_push arm64  arm64v8/alpine:latest ${TAG} ${KUBERNETES_RELEASE} ${REPO} $(dirname $0)/.
docker_image_build_and_push arm    arm32v7/alpine:latest ${TAG} ${KUBERNETES_RELEASE} ${REPO} $(dirname $0)/.

docker_manifest_create_and_push ${REPO}:${TAG}-${KUBERNETES_RELEASE} ${REPO}:${TAG} 