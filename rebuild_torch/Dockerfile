FROM haoyangz/deepsea-predict-docker
MAINTAINER Haoyang Zeng  <haoyangz@mit.edu>

COPY rebuild_torch.sh /root/torch/
RUN /root/torch/rebuild_torch.sh

WORKDIR /root/DeepSEA-v0.94/
