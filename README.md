<a href="https://hacknagpur.tech/"><img src="https://github.com/its-charan-here/HackNagpur_FaceSham/blob/main/documentation/images/hacknagpur_header.png"></a>
<a href="https://github.com/its-charan-here/HackNagpur_FaceSham"><img src="https://github.com/its-charan-here/HackNagpur_FaceSham/blob/main/documentation/images/facesham.png" ></a>

# DscWOW_FaceSham

Team : X-Radiant

Project Name : FaceSham

### Team members
* Vignesh Charan
* Poojan Panchal
* Sanskar Garodia

### Presentation : <a href="https://docs.google.com/presentation/d/1ncSGvFpZyul25qazbEMvW9SkmxTayI3FjUxdCjwz5Uc/edit?usp=sharing">Google Slides</a> | <a href = "https://youtu.be/6NWHHKnt9oc">YouTube</a>

### Problem Statement 

Now a days the AI based technology creates realistic fake images or videos of targeted people by swapping their faces another person saying or doing things that are not actually done by them. This has started creating trust issues and rather than benefiting anyone, this AI-based technology has disadvantages affecting different groups of our society. Apart from creating fake news and propaganda, deepfake is majorly used for revenge, to defame notable celebrities and politicians. 

### Solution
Deepfake detection includes solutions that leverage multi-modal detection techniques to determine whether target media has been manipulated or synthetically generated. Existing detection techniques can be loosely split into manual and algorithmic methods. Manual techniques include human media forensic practitioners, often armed with software tools. Algorithmic detection uses an AI-based algorithm to identify manipulated media.

### What is DeepFake?

Deepfakes are based on AI technology which creates seemingly realistic but fake images or videos of targeted people by swapping their faces with another person saying or doing things that are not actually done by them.

Deep learning + Fake = DeepFace

### Why DeepFake Detection?

DeepFake detection is imperative because :
- Proliferating of fake content is possible on social Media
- Fake content creates nuisance in politics as well as any person’s personal life.
- It Deceives us in believing things which are Sham. 
- The value of original content deteriorates.
- Difficult for a layperson to identify a DeepFake content and assess its authenticity.

<a href=""><img src="https://github.com/its-charan-here/HackNagpur_FaceSham/blob/main/documentation/images/deepfakeinfo.png" height=200px></a>

## Deep Fake Detector

Deep fake detector is build using BlazeFace Detection model and Xception image classification model. Once the input video is feed into the program, it is divided into frames and the BlazeFace detection model is applied on the frames to extract all the faces from the images. These faces are then encoded into a numpy array which will act as input data for Xception Classification model. This Xception classification model is a based on CNN architechure which is trained on the DeepFake dataset released by the Facebook in 2019 on Kaggle. You can find the dataset over [here](https://www.kaggle.com/c/deepfake-detection-challenge/data). Here, there is about 400GB of training data which contains short videos or both the classes (Natural and DeepFake). In order to train on huge dataset like this, lots of computational power is required as well as training this model take many days. Therefore, the open source trained weight are used, which are avaible [here](https://github.com/its-charan-here/DscWOW_FaceSham/tree/main/vision/weights/xception_trained_model). The following flow chart diagram explains the Deep Learning Pipeline. 

<a href=""><img src="https://github.com/its-charan-here/HackNagpur_FaceSham/blob/main/documentation/Deep%20Learning%20Pipeline.png" ></a>

## FaceSham App Flow

FaceSham app provide the interface for the users to filter their media. Initial step will be user uploading the video throught the app. The video is stored in firebase database, also onces the video is uploaded a flask api request is made which then indiates the cloud processing unit/local computer for starting the deeplearning pipeline on the input video. The result of the deep learning model is then sent back to the FaceSham app. The following flowchart diagram explains the same. 

<a href=""><img src="https://github.com/its-charan-here/HackNagpur_FaceSham/blob/main/documentation/Flow%20Chart.png" ></a>

## FaceSham UI

Following is the User Interface of the FaceSham App.
<a href=""><img src="https://github.com/its-charan-here/HackNagpur_FaceSham/blob/main/documentation/Introducing%20you%20FaceSham.png" ></a>

### Implementation 

FaceSham implementation includes two major parts, Flutter app itself and the server side Flask intergrated with Deep learning module. 

By following the mentioned steps one can install and run this app successfully in the local host- 

- Clone this repository and run the requirements.txt file in cmd or annaconda prompt using the following code 
```
pip install -r requirements.txt
```
- Start the app.py file from vision folder to initiate the deep learning pipeline and local host flask server using the following code.
```
python app.py
```
- Once the local host server is live, open the deepfake_wow folder and launch the flutter app. 

Note: Ensure to get all the packages in pubspec.yaml file. 

Fire up the flutter app and Fliter the Fake content!! 


