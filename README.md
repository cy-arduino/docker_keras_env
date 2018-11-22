# create a keras running env

## build image locally
* download dockerfile
* docker build --build-arg xxx=xxx -t chihyinglin/keras_env:x.x -f Dockerfile .
## push image
* commmit to https://github.com/cy-arduino/docker_keras_env
## pull image
* docker pull chihyinglin/keras_env
## run image
### jupyter notebook:
* docker run -p 0.0.0.0:[you port]:8888 -v [your code path]:/root/data chihyinglin/keras_env:x.x /root/anaconda3/bin/jupyter notebook --ip=* --allow-root
### cmd line
* docker run -v [your code path]:/root/data chihyinglin/keras_env:x.x [your cmd]
### auto run(container execute /root/data/run.sh automatically)
* docker run -v [your code path]:/root/data chihyinglin/keras_env:x.x
