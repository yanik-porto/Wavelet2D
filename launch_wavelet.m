clear;
close;
clc;

%% Apply wavelet decomposition
h0=[0.48296     0.83652     0.22414    -0.12941];
img=double(imread('lena256.bmp'));
wc = wavelet_dec(img, 2, h0);

figure(1);
ptr2d(wc,2);
colormap(gray(256));

wc = fwt_or_2d(0,img,2,h0); 

figure(2);
ptr2d(wc,2);
colormap(gray(256));