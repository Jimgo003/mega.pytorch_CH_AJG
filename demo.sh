#!/bin/bash

# 1. Ensure we stop if the first command fails (optional, but recommended)
set -e 

# 2. Double check we are in the right folder
if [ ! -f "R_101.pth" ]; then
    echo "Error: R_101.pth not found! Are you in the mega.pytorch_CH_AJG folder and have you downloaded the checkpoint file?"
    exit 1
fi

echo "Starting Image demo..."

python demo/demo.py base configs/vid_R_101_C4_1x.yaml R_101.pth --suffix ".JPEG" --visualize-path datasets/image_folder --output-folder visualization/demo/image

echo "--------------------------------"
echo "Image demo finished. Starting Video demo..."
echo "--------------------------------"

python demo/demo.py base configs/vid_R_101_C4_1x.yaml R_101.pth --video --visualize-path datasets/sesion2/v_HorseRiding_g10_c01.avi --output-folder visualization/demo/video
