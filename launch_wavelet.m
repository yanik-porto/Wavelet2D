clear;
close;
clc;

%% Get image and lowpass filter analysis
h0 = [0.48296     0.83652     0.22414    -0.12941];
% img = double(imread('lena256.bmp'));
img = double(rgb2gray(imread('montagne.jpg')));

sz = size(img, 1);

sb = img+randn(sz,sz)*10;

%% Apply wavelet decomposition
wc = wavelet_dec(img, 2, h0);

%% Selection of 10% large coefficient
coef=abs(wc(:));
coef=sort(coef);
threshold=coef(floor(length(coef)*0.95));
wc2=wc.*(abs(wc)>threshold);
wc2=floor(wc2);

%% Apply wavelet reconstruction
rec = wavelet_rec(wc2, 2, h0);

%% Visualize
figure(1); subplot(121);
ptr2d(wc,2);
colormap(gray(256));
subplot(122), affiche(rec);