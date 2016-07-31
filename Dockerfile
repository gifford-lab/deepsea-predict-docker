FROM kaixhin/cuda-torch:7.0
MAINTAINER Haoyang Zeng  <haoyangz@mit.edu>

RUN apt-get update
RUN apt-get update && apt-get install -y \
    curl \
	emacs24-nox \
	gcc-4.8-plugin-dev \
	libhdf5-dev \
	luarocks \
	libmatio2 \
	nano \
	pkg-config \
	git \
	python-setuptools python-dev build-essential 

RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -
RUN apt-get update
RUN apt-get -y install r-base

RUN pip install numpy pandas h5py statsmodels joblib biopython

RUN git clone https://github.com/bedops/bedops.git;cd bedops;make

COPY tabix-0.2.6.tar.bz2 /root/
RUN cd /root/; tar xvjf tabix-0.2.6.tar.bz2; cd tabix-0.2.6;make
ENV PATH=/root/tabix-0.2.6:$PATH

RUN apt-get install -y r-base-dev r-cran-rcurl r-cran-xml
COPY rscript.R /root/
RUN Rscript /root/rscript.R

# Get required Lua packages.
#RUN /root/torch/install/bin/luarocks install cutorch 
#RUN /root/torch/install/bin/luarocks install cunn
RUN /root/torch/install/bin/luarocks install hdf5

# Bring DeepSEA source code into the image.
RUN wget http://deepsea.princeton.edu/media/code/deepsea.v0.94.tar.gz;tar -zxvf deepsea.v0.94.tar.gz -C /root/

WORKDIR /root/DeepSEA-v0.94/

