import os, sys, time
import cv2
import numpy as np
import pandas as pd

import torch
import torch.nn as nn
import torch.nn.functional as F

# %matplotlib inline
import matplotlib.pyplot as plt

import warnings
warnings.filterwarnings("ignore")

import sys
from blazeface import BlazeFace
from utils.read_video_1 import VideoReader
from utils.face_extract_1 import FaceExtractor

import torch.nn as nn
import torchvision.models as models

from concurrent.futures import ThreadPoolExecutor

from torchvision.transforms import Normalize


gpu = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
print(gpu)

sys.path.insert(0, "/weights/pytorch_bazeface")
sys.path.insert(0, "/weights/inference")


facedet = BlazeFace().to(gpu)
facedet.load_weights("weights/pytorch_blazeface/blazeface.pth")
facedet.load_anchors("weights/pytorch_blazeface/anchors.npy")
_ = facedet.train(False)

frames_per_video = 81 #frame_h * frame_l
video_reader = VideoReader()
video_read_fn = lambda x: video_reader.read_frames(x, num_frames=frames_per_video)
face_extractor = FaceExtractor(video_read_fn, facedet)

input_size = 480


mean = [0.485, 0.456, 0.406]
std = [0.229, 0.224, 0.225]
normalize_transform = Normalize(mean, std)

print("PyTorch version:", torch.__version__)
print("CUDA version:", torch.version.cuda)
print("cuDNN version:", torch.backends.cudnn.version())


def main_fake(in_video):

    test_videos =[in_video]


    def isotropically_resize_image(img, size, resample=cv2.INTER_AREA):
        h, w = img.shape[:2]
        if w > h:
            h = h * size // w
            w = size
        else:
            w = w * size // h
            h = size

        resized = cv2.resize(img, (w, h), interpolation=resample)
        return resized


    def make_square_image(img):
        h, w = img.shape[:2]
        size = max(h, w)
        t = 0
        b = size - h
        l = 0
        r = size - w
        return cv2.copyMakeBorder(img, t, b, l, r, cv2.BORDER_CONSTANT, value=0)



    class MyResNeXt(models.resnet.ResNet):
        def __init__(self, training=True):
            super(MyResNeXt, self).__init__(block=models.resnet.Bottleneck,
                                            layers=[3, 4, 6, 3], 
                                            groups=32, 
                                            width_per_group=4)
            self.fc = nn.Linear(2048, 1)

    checkpoint = torch.load("weights/inference/resnext.pth", map_location=gpu)

    model = MyResNeXt().to(gpu)
    model.load_state_dict(checkpoint)
    _ = model.eval()

    del checkpoint


    def predict_on_video(video_path, batch_size):
        try:
            
            faces = face_extractor.process_video(video_path)

            face_extractor.keep_only_best_face(faces)
            
            if len(faces) > 0:
                x = np.zeros((batch_size, input_size, input_size, 3), dtype=np.uint8)

                n = 0
                for frame_data in faces:
                    for face in frame_data["faces"]:
                        resized_face = isotropically_resize_image(face, input_size)
                        resized_face = make_square_image(resized_face)

                        if n < batch_size:
                            x[n] = resized_face
                            n += 1
                        else:
                            print("WARNING: have %d faces but batch size is %d" % (n, batch_size))
                        
                if n > 0:
                    x = torch.tensor(x, device=gpu).float()

                    x = x.permute((0, 3, 1, 2))

                    for i in range(len(x)):
                        x[i] = normalize_transform(x[i] / 255.)
                    with torch.no_grad():
                        y_pred = model(x)
                        y_pred = torch.sigmoid(y_pred.squeeze())
                        return y_pred[:n].mean().item()

        except Exception as e:
            print("Prediction error on video %s: %s" % (video_path, str(e)))

        return 1



    def predict_on_video_set(videos, num_workers):
        def process_file(i):
            filename = videos[i]
            y_pred = predict_on_video(filename, batch_size=frames_per_video)
            return y_pred

        with ThreadPoolExecutor(max_workers=num_workers) as ex:
            predictions = ex.map(process_file, range(len(videos)))

        return list(predictions)


    predictions = predict_on_video_set(test_videos, num_workers=4)

    if predictions[0] == 1:
        val = "error"
    elif predictions[0] > 0.3:
        val = "It is a DeepFake Video" 
    else:
        val = "It looks Genuine"


    return val



val = main_fake(r"test_videos/test_vid.mp4")
print(val)