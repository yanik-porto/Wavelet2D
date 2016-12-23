clear;
close;
clc;

%% Get image and lowpass filter analysis
h0 = [0.48296     0.83652     0.22414    -0.12941];
% img = double(imread('lena256.bmp'));
img = double(rgb2gray(imread('montagne.jpg')));
sz = size(img, 1);

%Apply gaussian white noise
img_noise = img+randn(sz,sz)*15;

%% Apply wavelet decomposition
wc = wavelet_dec(img_noise, 2, h0);

%% Estimate noise level
for k = 1:5
    %Estimation of the noise level, from coeff of first scale
    scale = [wc(sz/2+1:sz,1:sz/2) wc(sz/2+1:sz,sz/2+1:sz) wc(1:sz/2,sz/2+1:sz)];
    sigma = median(abs(scale(:)))/0.6745; %Proportion of 50%
    threshold = k*sigma; %level of noise times 3 for the threshold
    %in gaussian, 3*std removes all noise

    %% Apply hard thresholding
    wc2 = wc.*(abs(wc)>=threshold);

    %% Apply soft thresholding
%     wc2=(sign(wc).*(abs(wc)-threshold)).*((abs(wc)>=threshold));

    %% Apply wavelet reconstruction
    rec = wavelet_rec(wc2, 2, h0);

    %% Visualize
%     figure(1); 
%     subplot(131), imshow(img_noise,[]);
%     subplot(132); ptr2d(wc,2); colormap(gray(256));
%     subplot(133), %affiche(rec);
%     imshow(rec, []);

    %% Compute PSNR
    [peak_snr(k), snr(k)] = psnr(rec, img);
end

figure;
plot(snr, '-*');
title('snr according to the number of std');
xlabel('number of std');
ylabel('snr (dB)');