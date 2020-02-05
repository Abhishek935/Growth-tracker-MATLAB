clear variables
clc
close all
vidObj = VideoReader('ecoli_growth4.avi'); % reads the video file
data = read(vidObj, Inf);  % reads the last frame of video file
numFrames = vidObj.NumberOfFrames; % determines the number of frmaes in the video

area2 = zeros(numFrames,1);
 for ii = 1: numFrames
     image = read(vidObj, ii); 
     A=rgb2gray(image);
     
     if ii == 1
         imshow (A)
         prompt1 = 'What is the threshold? ';
         Th = input(prompt1);
         A(A<Th) = 0;
         
        figure
        imshow(A)
         prompt2 = 'if happy with threshold press 1 else 0';
         Happy = input(prompt2);
     end
     if Happy == 0
         disp('Run again and select the correct threshold')
         break
     end
     if Happy == 1
      
          A(A<Th) = 0;
          B = im2bw(A);
        stats = regionprops(B,'Area');
        area = cat(1,stats.Area);
        area2(ii) = area;
     end


 end
 figure(3)
  Time = (1:numFrames).^0.5;
plot(Time,area2,'- * k')
xlabel('Time')
ylabel('Area')
title('E. coli growth curve')
