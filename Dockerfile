FROM ubuntu:18.04
MAINTAINER Ivar Grytten (ivargry@ifi.uio.no)

# Ignore mirror prompt when install things
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# General
RUN apt-get update && apt-get install -y wget tabix locales bc jq git zlib1g-dev
RUN locale-gen en_US.UTF-8

# Install R
# r package dependencies:
RUN apt-get update && apt install -y libcurl4-openssl-dev libxml2-dev apt-transport-https software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && apt-get update && apt install -y r-base build-essential

# Python 3
RUN apt update && apt install -y python3-pip build-essential libssl-dev libffi-dev python3-dev
RUN pip3 install numpy

# Python packages
RUN pip3 install offsetbasedgraph==2.1.4
RUN pip3 install rough_graph_mapper==0.0.4

# Two step Graph Mapper
RUN git clone https://github.com/uio-bmi/two_step_graph_mapper.git && cd two_step_graph_mapper && pip3 install -e .

# Minimap 2
RUN wget https://github.com/lh3/minimap2/releases/download/v2.15/minimap2-2.15_x64-linux.tar.bz2
RUN tar -xjvf minimap2-2.15_x64-linux.tar.bz2 
RUN mv minimap2-2.15_x64-linux/minimap2 /usr/bin/

# Hisat 2
RUN apt-get update && apt install -y hisat2=2.1.0-1

# vg
RUN wget https://github.com/vgteam/vg/releases/download/v1.12.1/vg
RUN chmod a+x vg && mv vg /usr/bin/

# bwa mem
RUN apt-get update && apt install bwa=0.7.17-1

# mitty
RUN pip3 install git+https://github.com/sbg/Mitty.git@e299649f71b78da036b25a96cec3440764095c87











