function wc = wavelet_dec(img, J, h0)

%% Compute high-pass filter
%Definition of the analysis High pass filter
for n=0:length(h0)-1,
   g0(n+1)=h0(n+1)*(-1)^(n+1);
end;
g0=g0(length(g0):-1:1);

%% Apply wavelet decomposition on the horizontal part of the image
% Then apply the wavelet decomposition on the vertical part of the result
coarse = img;

for k = 1:J
    
    %%Tune the filter for the certain J level
    row = size(coarse,1);
    col = size(coarse,2);
    
    %%Filter the horizontal part
    sd1_horiz = zeros(size(coarse));

    for i = 1:row
        % Take one row of the image at a time
        im_row = coarse(i,:);

        % Lowpass filtering
        im_row_lf=pconv(h0,im_row); %Periodic convolution
        % Downsampling
        sd1_horiz(i,1:col/2) = im_row_lf(1:2:length(im_row_lf)); 

        % Highpass filtering
        im_row_hf=pconv(g0,im_row);
        % Downsampling
        sd1_horiz(i,col/2+1:col)=im_row_hf(1:2:length(im_row_hf));
    end

    %%Filter the vertical part
    sd1_vert = zeros(size(coarse));

    for j = 1:col
        % Take one row of the image at a time
%         im_col = coarse(:,j);
        im_col = sd1_horiz(:,j);

        % Lowpass filtering
        im_col_lf = pconv(h0,im_col')'; %Periodic convolution
        % Downsampling
        sd1_vert(1:row/2,j) = im_col_lf(1:2:length(im_col_lf)); 

        % Highpass filtering
        im_col_hf = pconv(g0,im_col')';
        % Downsampling
        sd1_vert(row/2+1:row,j) = im_col_hf(1:2:length(im_col_hf));
    end

    %Save the result of the level
    wc(1:row, 1:col) = sd1_vert;
    coarse = wc(1:row/2, 1:col/2);
end
