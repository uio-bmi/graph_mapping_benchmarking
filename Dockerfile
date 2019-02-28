FROM ubuntu:18.04
MAINTAINER Ivar Grytten (ivargry@ifi.uio.no)

# Ignore mirror prompt when install things
ENV DEBIAN_FRONTEND=noninteractive  

# General
RUN apt-get update
RUN apt-get install -y wget, tabix, locales, bc
RUN apt install -y git
RUN apt install -y zlib1g-dev
RUN locale-gen en_US.UTF-8

# Minimap 2
RUN wget https://github.com/lh3/minimap2/releases/download/v2.15/minimap2-2.15_x64-linux.tar.bz2
RUN tar -xjvf minimap2-2.15_x64-linux.tar.bz2 
RUN mv minimap2-2.15_x64-linux/minimap2 /usr/bin/

# vg
RUN wget https://github.com/vgteam/vg/releases/download/v1.14.0/vg
RUN chmod a+x vg && mv vg /usr/bin/

# bwa mem
RUN apt install bwa=0.7.17-1

# Python 3
RUN apt install -y python3-pip
RUN apt install -y build-essential libssl-dev libffi-dev python3-dev                       

# mitty
RUN pip3 install git+https://github.com/sbg/Mitty.git@e299649f71b78da036b25a96cec3440764095c87

# Python packages
RUN pip3 install offsetbasedgraph==2.1.4
RUN pip3 install rough_graph_mapper==0.0.3


# Install R
RUN apt install -y  apt-transport-https software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN apt update
RUN apt install -y r-base
RUN apt install -y build-essential








