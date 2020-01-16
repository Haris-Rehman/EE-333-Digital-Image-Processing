im1 = rgb2gray(imread('seecs.jpg'));
im2 = rgb2gray(imread('nasa.jpg'));
 
[A,B]=size(im1);
im2=imresize(im2,[A,B]);
 
im1_right_shift = bitshift(im1,-4);
im1_left_shift = bitshift(im1_right_shift,4);
 
im2_right_shift = bitshift(im2,-4);
im2_left_shift = bitshift(im2_right_shift,4);
 
 figure; 
 subplot(2,2,1); imshow(im1);
subplot(2,2,3); imshow(im1_right_shift);
 subplot(2,2,4); imshow(im1_left_shift);
%  
 figure; 
subplot(2,2,1); imshow(im2);
subplot(2,2,3); imshow(im2_right_shift);
subplot(2,2,4); imshow(im2_left_shift);
 
%im2_right_shift=imadjust(im2_right_shift,[0,0.0001],[]);
combined_img = bitor(im1_right_shift,  im2_left_shift);
 
figure;     
imshow(combined_img)
