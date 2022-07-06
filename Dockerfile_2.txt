# creating docker container from ubuntu
docker run -t -d ubuntu --name ob_container
docker exec -it ob_container /bin/bash

# Start with a base Ubuntu image
ubuntu

# Install miniconda with python 3.7
curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh
bash miniconda.sh -p /miniconda -b     # might need -y as well
rm miniconda.sh
export PATH=/miniconda/bin:${PATH}

# create conda environment called OBModel
conda create --name OBModel python=3.7
conda activate OBModel

conda install Cython>=0.28.1
conda install jsonpickle>=0.9.6
conda install matplotlib>=2.2.2
conda install mpi4py>=3.0.0
conda install numpy>=1.18.5
conda install pandas>=1.0.3
conda install peewee>=3.13.3
conda install quantities>=0.12.1
conda install scipy>=1.4.1
conda install deap>=1.2.2
conda install pysqlite3>=0.4.3

conda install -c conda-forge neuron==7.8.2
#conda install neuron-7.7.2-mpi_openmpi_py37hcea4ffe_1
#conda install neuron-7.7.2-mpi_openmpi_py37hcea4ffe_1 -c conda-forge
#conda install neuron-7.7.2-mpi_openmpi_py37hcea4ffe_1.tar.bz2
#conda install openmpi

git clone https://github.com/scidash/sciunit
git clone https://github.com/scidash/neuronunit
pip install -e . 
pip install sciunit
pip install neuronunit
git checkout prime
git pull origin prime

pip install blenderneuron==2.0.4
pip install neo
pip install LFPsimpy==0.1.1
