FROM python:3.10

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
# RUN yum update && yum install ffmpeg libsm6 libxext6  -y

# To fix ERROR: This script must not be launched as root, aborting...
# ------------------------------------------------------------------
RUN adduser --disabled-password --gecos '' user
RUN mkdir /content && chown -R user:user /content
WORKDIR /content
USER user
# ------------------------------------------------------------------


# Download the webui.sh script from the URL
RUN curl -O https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

# Make the script executable (if needed)
RUN chmod +x ./webui.sh

# Below command will get docker build command stuck because it starts a server and never exits
#RUN ./webui.sh --skip-torch-cuda-test --precision full --no-half --listen

EXPOSE 7860

# Define the command to run your script
CMD ["bash", "webui.sh", "--skip-torch-cuda-test", "--precision", "full", "--no-half", "--listen"]



