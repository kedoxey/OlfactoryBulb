FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl gcc git

# CMD ["curl", "-o", "miniconda.sh", "https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh"]

RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh

RUN bash miniconda.sh -p /miniconda -b
RUN rm miniconda.sh
ENV PATH="/miniconda/bin:${PATH}"

RUN echo $PATH

COPY conda_requirements.txt ./
COPY pip_requirements.txt ./

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r pip_requirements.txt

# RUN conda update -n base -c defaults conda

RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict

RUN conda install --file conda_requirements.txt
RUN conda install neuron==7.8.2

RUN git clone https://github.com/scidash/sciunit
WORKDIR "/sciunit"
RUN pip install -e .
WORKDIR "/"

RUN git clone https://github.com/scidash/neuronunit
WORKDIR "/neuronunit"
RUN git checkout prime
RUN git pull origin prime
RUN pip install -e . 
WORKDIR "/"

RUN git clone https://github.com/ellismith/OlfactoryBulb.git

