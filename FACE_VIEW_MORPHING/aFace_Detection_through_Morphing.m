clear;clc;close all;

%This code is used to implement the face morphing algorithm

face1 = imread('leff.jpg');
face2 = imread('rigf.jpg');


 %resize the two images
[M1,N1,P] = size(face1);
[M2,N2,P] = size(face2);

M = min([M1,M2]);
N = min([N1,N2]);

face1 = imresize(face1,[M,N]);
face2 = imresize(face2,[M,N]);

[f1_eye1,f1_eye2,f1_mouth,f1show] = DetectEyeMouth(face1);
[f2_eye1,f2_eye2,f2_mouth,f2show] = DetectEyeMouth(face2);

% let's start face morphing

vidObj = VideoWriter('FaceMorphing.avi');
filename = 'Video.gif';
open(vidObj);
i = 1;
for alpha = 0:0.1:1
% alpha = 0.3;
    interf_eye1 = alpha*f1_eye1+(1-alpha)*f2_eye1;
    interf_eye2 = alpha*f1_eye2+(1-alpha)*f2_eye2;
    interf_mouth = alpha*f1_mouth+(1-alpha)*f2_mouth;
    face1t = CoTrans(double(face1),[f1_eye1;f1_eye2;f1_mouth],[interf_eye1;interf_eye2;interf_mouth]);
    face2t = CoTrans(double(face2),[f2_eye1;f2_eye2;f2_mouth],[interf_eye1;interf_eye2;interf_mouth]);
    
    im = face1t*alpha+(1-alpha)*face2t;    

    [im_eye1,im_eye2,im_mouth,imshow] = DetectEyeMouth2(im);  %to see individual processing put DetectEyeMouth instead of DetectEyeMouth2
   % im = reddot(im,[im_eye1;im_eye2;im_mouth]);
    
    
    %pause(0.5);
    currFrame = getframe;
    im = frame2im(currFrame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    i = i+1;
    for j=1:5
    writeVideo(vidObj,currFrame);
    end
end
close(vidObj);