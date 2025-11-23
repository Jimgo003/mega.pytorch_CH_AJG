#important, in order for the demo to work you must be in the mega.pytorch_CH_AJG folder and you should have downloaded the checkpoint files
echo "Starting Image demo..."
python demo/demo.py base configs/vid_R_101_C4_1x.yaml R_101.pth --suffix ".JPEG" --visualize-path datasets/image_folder --output-folder visualization/demo/image 
echo "Starting Video demo..."
python demo/demo.py base configs/vid_R_101_C4_1x.yaml R_101.pth --video --visualize-path datasets/sesion2/v_HorseRiding_g10_c01.avi --output-folder visualization/demo/video 
