#!/bin/bash

# Stop the script if any command fails
set -e

# 1. Initialize Conda for use inside this script
# Change '~/anaconda3' to '~/miniconda3' depending on your install
eval "$(conda shell.bash hook)"

echo "Creating Conda Environment..."
conda create --name MEGA -y python=3.7

echo "Activating Environment..."
conda activate MEGA

# 2. Install Dependencies
echo "Installing basic dependencies..."
conda install -y ipython pip

# Attempting to pin versions to ensure Python 3.7 compatibility
pip install ninja yacs cython matplotlib tqdm opencv-python scipy

# 3. Install PyTorch (Legacy)
echo "Installing PyTorch 1.2.0..."
# Note: Ensure your GPU supports CUDA 10.0!
conda install -y pytorch=1.2.0 torchvision=0.4.0 'pillow<7.0.0' cudatoolkit=10.0 -c pytorch

export INSTALL_DIR=$PWD

# 4. Install PyCOCOTools
echo "Installing COCO API..."
cd $INSTALL_DIR
if [ ! -d "cocoapi" ]; then
    git clone https://github.com/cocodataset/cocoapi.git
fi
cd cocoapi/PythonAPI
python setup.py build_ext install

# 5. Install Cityscapes
echo "Installing Cityscapes Scripts..."
cd $INSTALL_DIR
if [ ! -d "cityscapesScripts" ]; then
    git clone https://github.com/mcordts/cityscapesScripts.git
fi
cd cityscapesScripts/
python setup.py build_ext install

# 6. Install Apex
# WARNING: This requires your system 'nvcc' to match CUDA 10.0
echo "Installing Apex..."
cd $INSTALL_DIR
if [ ! -d "apex_CH_AJG" ]; then
    git clone https://github.com/Jimgo003/apex_CH_AJG.git
fi
cd apex_CH_AJG
# Apex often requires this flag to build correctly on older setups
python setup.py build_ext install

# 7. Install MEGA
echo "Installing MEGA..."
cd $INSTALL_DIR
if [ ! -d "mega.pytorch_CH_AJG" ]; then
    git clone https://github.com/Jimgo003/mega.pytorch_CH_AJG.git
fi
cd mega.pytorch_CH_AJG

python setup.py build develop

# Force downgrade Pillow again just in case setup.py upgraded it
pip install 'pillow<7.0.0'

unset INSTALL_DIR
echo "Installation Complete!"
