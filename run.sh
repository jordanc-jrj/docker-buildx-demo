rm -rf ./cache/ ./inspect/
mkdir -p ./inspect/
docker buildx rm builder0 || true
docker buildx create --name builder0 --driver docker-container
docker buildx bake --builder builder0 -f images.json --progress=plain --load
docker image inspect apple:latest > ./inspect/inspect1.log
docker buildx bake --builder builder0 -f images.json --progress=plain --load
docker image inspect apple:latest > ./inspect/inspect2.log
docker buildx rm builder0 && docker buildx create --name builder0 --driver docker-container
docker buildx bake --builder builder0 -f images.json --progress=plain --load
docker image inspect apple:latest > ./inspect/inspect3.log