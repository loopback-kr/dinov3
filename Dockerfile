FROM docker.io/pytorch/pytorch:2.11.0-cuda12.8-cudnn9-devel

# Set Environment Variables
ARG DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1
ENV PYTHONDONTWRITEBYTECODE=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    PIP_ROOT_USER_ACTION=ignore

# Install python packages (torch/torchvision come from the base image; devel image keeps gcc for torch.compile/triton)
COPY ./requirements.txt /tmp/requirements.txt
RUN sed -E '/^(torch|torchvision)([=<>~!].*)?$/d' /tmp/requirements.txt > /tmp/requirements-notorch.txt \
&& pip install -r /tmp/requirements-notorch.txt \
&& rm /tmp/requirements.txt /tmp/requirements-notorch.txt
