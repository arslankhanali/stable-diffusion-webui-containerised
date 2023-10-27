# Introduction
Containerising Stable Diffusion web UI for the purpose of running locally or in OpenShift

#### Notes
1. Remember to increase memory and CPU of docker machine
2. Don't write commands in RUN which start a server because then it does not exit and build process gets stuck
3. Build the container, run it, it will download all the models (18Gb) etc and then commit the container to have an image will all the neccessary files.
4. `--listen` will bind to 0.0.0.0 instead of 127.0.0.1. `127.0.0.1` cannot be exposed outside container.
5. `--skip-torch-cuda-test` will run it on CPU instead of CUDA
6. `--no-cache` will not use cache when building a container

#### Run on mac locally (no containers)
``` sh
ch /Users/arslankhan/Codes/stable-diffusion-webui
./webui.sh --skip-torch-cuda-test --precision full --no-half
./webui.sh --skip-torch-cuda-test --precision full --no-half --listen 
```

#### build container locally
``` sh
# Start machine
docker machine start

# Build container
docker build --no-cache -t stable-diffusion-webui:1 .
# docker build -t stable-diffusion-webui:1 .

# Start and run container
docker run -d --name stable-diffusion-webui -p 7870:7860 stable-diffusion-webui:1

# Create an image from the  container. So it does not download 18Gb of content each time we run it
docker commit stable-diffusion-webui stable-diffusion-webui-final

# Run container with everything downloaded already (apprx size 18Gb)
docker run -d --name stable-diffusion-webui-final -p 7870:7860 stable-diffusion-webui-final

```
[`Access GUI`](http://127.0.0.1:7870/)

## Rough Notes (ignore)
#### testing
curl http://127.0.0.1:7860
curl http://localhost:7860
curl http://0.0.0.0:7860
curl http://192.168.1.106:7860

curl http://127.0.0.1:80
curl http://localhost:80
curl http://0.0.0.0:80
curl http://192.168.1.106:80

curl http://127.0.0.1:7861
curl http://localhost:7861
curl http://0.0.0.0:7861
curl http://192.168.1.106:7861