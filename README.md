# Docker image for keras + tensorflow

## pull image
* docker pull chihyinglin/keras_env
## push image
* commmit to https://github.com/cy-arduino/docker_keras_env
## build image locally
* download dockerfile
* docker build --build-arg xxx=xxx -t chihyinglin/keras_env:x.x -f Dockerfile .
## run image
### jupyter notebook:
* docker run -p 0.0.0.0:[you port]:8888 -v [your code path]:/root/data chihyinglin/keras_env:x.x /root/anaconda3/bin/jupyter notebook --ip=* --allow-root
### cmd line
* docker run -v [your code path]:/root/data chihyinglin/keras_env:x.x [your cmd]
### auto run(container execute /root/data/run.sh automatically)
* docker run -v [your code path]:/root/data chihyinglin/keras_env:x.x
