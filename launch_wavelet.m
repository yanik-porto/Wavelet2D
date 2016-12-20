clear;
close;
clc;

%% Apply wavelet decomposition
h0=[0.48296     0.83652     0.22414    -0.12941];
img=double(imread('lena256.bmp'));
wc = wavelet_dec(img, 2, h0);
rec = wavelet_rec(wc, 2, h0);

figure(1); subplot(121);
ptr2d(wc,2);
colormap(gray(256));

subplot(122), affiche(rec);

%% Wavelet decomposition (from teacher)

wc = fwt_or_2d(0,img,2,h0); 
rec = fwt_or_2d(1,wc,2,h0);

figure(2); subplot(121);
ptr2d(wc,2);
colormap(gray(256));

subplot(122), affiche(rec);