# Wavelet2D
Apply a wavelet decomposition on an image and reconstruct from the coefficient

## launch_wavelet.m
-Decompose the original image in multiple levels of wavelet transform
-Reconstruct the image from a certain percentage of the coefficients

## launch_wavelet_noise.m
-Add noise on the original image
-Decompose the original image in multiple levels of wavelet transform
-Estimate the noise thanks to the first scales of the decomposition
-Apply hard or soft thresholding 
-Reconstruct the image
