FROM ubuntu:18.04
MAINTAINER Ivar Grytten (ivargry@ifi.uio.no)

# Ignore mirror prompt when install things
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# General
RUN apt-get update && apt-get install -y wget tabix locales bc jq git zlib1g-dev
RUN locale-gen en_US.UTF-8

# Python 3
RUN apt update && apt install -y python3-pip build-essential libssl-dev libffi-dev python3-dev
RUN pip3 install numpy

# Python packages
RUN pip3 install offsetbasedgraph==2.1.4
RUN pip3 install numpy_alignments==0.0.2

# Needed to install pysam
RUN apt-get install -y build-essential
RUN apt-get install -y libbz2-dev liblzma-dev

# Rough graph mapper
RUN git clone https://github.com/uio-bmi/rough_graph_mapper.git && \
    cd rough_graph_mapper && \
    git checkout v1.0.0 && \
    pip3 install -e . && \
    cd scripts  && \
    echo "export PATH=$(pwd):\${PATH}" >> ~/.profile


# Two step Graph Mapper
RUN if cd two_step_graph_mapper; then git pull; else git clone https://github.com/uio-bmi/two_step_graph_mapper.git; fi && cd two_step_graph_mapper && pip3 install -e . && \
    cd scripts && echo "export PATH=$(pwd):\${PATH}" >> ~/.profile

# Minimap 2
RUN wget https://github.com/lh3/minimap2/releases/download/v2.15/minimap2-2.15_x64-linux.tar.bz2
RUN tar -xjvf minimap2-2.15_x64-linux.tar.bz2 
RUN mv minimap2-2.15_x64-linux/minimap2 /usr/bin/

# Hisat 2
RUN apt-get update && apt install -y hisat2=2.1.0-1

# vg
RUN wget https://github.com/vgteam/vg/releases/download/v1.19.0/vg
RUN chmod a+x vg && mv vg /usr/bin/

# bwa mem version 2
RUN git clone https://github.com/bwa-mem2/bwa-mem2 && cd bwa-mem2 && make && chmod a+x bwa-mem2 && cp bwa-mem2 /usr/bin/.


##### Stuff only needed for variant calling analysis:

# Sambamba
RUN wget https://github.com/biod/sambamba/releases/download/v0.7.0/sambamba-0.7.0-linux-static.gz && \
    gunzip sambamba-0.7.0-linux-static.gz && chmod a+x sambamba-0.7.0-linux-static && mv sambamba-0.7.0-linux-static /usr/bin/sambamba

#Hap.py
#RUN apt install -y cmake, autoconf
#RUN apt install -y python2.7, python-pip
#RUN git clone https://github.com/Illumina/hap.py.git && \
    #cd hap.py && \
    #python2.7 install.py /usr/bin/

# Graphtyper
RUN wget https://github.com/DecodeGenetics/graphtyper/releases/download/v2.0-beta/graphtyper && chmod a+x graphtyper && mv graphtyper /usr/bin

# Graphtyper-pipeline
RUN git clone https://github.com/DecodeGenetics/graphtyper-pipelines.git















