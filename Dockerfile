FROM kaixhin/torch
MAINTAINER Haoyang Zeng  <haoyangz@mit.edu>

RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    cython \
    emacs24-nox \
    gcc-4.8-plugin-dev \
    git \
    libhdf5-dev \
    libmatio2 \
    luarocks \
    nano \
    pkg-config \
    python-dev \
    python-numpy \
    python-scipy \
    python-setuptools \
    r-base \
    r-base-dev \
    r-cran-rcurl \
    r-cran-xml \
    tabix

RUN pip install \
    biopython \
    h5py \
    joblib \
    numpy \
    pandas \
    statsmodels

RUN git clone https://github.com/bedops/bedops.git && cd bedops && make

RUN sh -c 'echo "source(\"http://bioconductor.org/biocLite.R\") \n \
    biocLite(\"BSgenome.Hsapiens.UCSC.hg19\") \n \
	    biocLite(\"TxDb.Hsapiens.UCSC.hg19.knownGene\")\n" > rscript.R '
RUN Rscript rscript.R

# Get required Lua packages.
# RUN /root/torch/install/bin/luarocks install cutorch
# RUN /root/torch/install/bin/luarocks install cunn
RUN /root/torch/install/bin/luarocks install hdf5

# Bring DeepSEA source code into the image.
RUN wget -q http://deepsea.princeton.edu/media/code/deepsea.v0.94.tar.gz && tar -zxvf deepsea.v0.94.tar.gz -C /root/ > /dev/null

WORKDIR /root/DeepSEA-v0.94/
