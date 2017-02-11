
clear;clc;close all;
%This code performes View Morphing for still images and detects eyes and
%mouth in the morphed image
face1 = imread('t1.jpg');
face2 = imread('t2.jpg');

% resize the two images
[M1,N1,P] = size(face1);
[M2,N2,P] = size(face2);

M = min([M1,M2]);
N = min([N1,N2]);
face1 = imresize(face1,[M,N]);
face2 = imresize(face2,[M,N]);
figure;
[f1_eye1,f1_eye2,f1_mouth,f1show] = DetectEyeMouth(face1);
[f2_eye1,f2_eye2,f2_mouth,f2show] = DetectEyeMouth(face2);
%imshow1 = reddot(face1,[f1_eye1;f1_eye2;f1_mouth]);
%imshow2 = reddot(face2,[f2_eye1;f2_eye2;f2_mouth]);
%subplot(121); imshow(imshow1,[]);title('Face 1');
%subplot(122);imshow(imshow2,[]);title('Face 2');
%---------------start face morphing----------------
alpha=0.5; 
interf_eye1 = alpha*f1_eye1+(1-alpha)*f2_eye1;
    interf_eye2 = alpha*f1_eye2+(1-alpha)*f2_eye2;
    interf_mouth = alpha*f1_mouth+(1-alpha)*f2_mouth;
    face1t = CoTrans(double(face1),[f1_eye1;f1_eye2;f1_mouth],[interf_eye1;interf_eye2;interf_mouth]);
    face2t = CoTrans(double(face2),[f2_eye1;f2_eye2;f2_mouth],[interf_eye1;interf_eye2;interf_mouth]);
    im = face1t*alpha+(1-alpha)*face2t;
    
%Detect mouth and eyes in the morphed face    
    [im_eye1,im_eye2,im_mouth,imshow] = DetectEyeMouth(im);
   % im = reddot(im,[im_eye1;im_eye2;im_mouth]);
       
    currFrame = getframe;
    im = frame2im(currFrame);
    [imind,cm] = rgb2ind(im,256);
    
    
