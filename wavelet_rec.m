function rec = wavelet_rec(wc, J, h0)

%% Compute high-pass filter
%Definition of the analysis High pass filter
for n=0:length(h0)-1,
   g0(n+1)=h0(n+1)*(-1)^(n+1);
end;
g0=g0(length(g0):-1:1);

%% Apply wavelet reconstruction on the vertical part of the image
% Then apply the wavelet reconstruction on the horizontal part of the result

for pow = J-1:-1:0
    row = size(wc, 1)/(2^pow);
    col = size(wc, 2)/(2^pow);
    wc_level = wc(1:row, 1:col);

    rec_vert = zeros(row, col);
    for j = 1:col
        wc_col = wc_level(:, j);
        
        % Upsampling
        wc_col_lf = zeros(row, 1); %Build array of zeros
        wc_col_lf(1:2:length(wc_col_lf)) = wc_col(1:row/2); %Fill 1/2 with values from coeff
        % Inverse Lowpass filtering
        wc_col_lf = pconv(h0,fliplr(wc_col_lf'))'; %fliplr is the reverse process

        % Upsampling
        wc_col_hf=zeros(row, 1);
        wc_col_hf(1:2:length(wc_col_hf)) = wc_col(row/2+1:row);
        % Inverse Highpass filtering
        wc_col_hf = pconv(g0,fliplr(wc_col_hf'))';

        % Reconstruct 
        rec_vert(:,j) = fliplr((wc_col_hf+wc_col_lf)')';
    end
    
    rec_horiz = zeros(row, col);
    for i = 1:row
        wc_row = rec_vert(i,:);
        
        % Upsampling
        wc_row_lf = zeros(1, col); %Build array of zeros
        wc_row_lf(1:2:length(wc_row_lf)) = wc_row(1, 1:col/2); %Fill 1/2 with values from coeff
        % Inverse Lowpass filtering
        wc_row_lf = pconv(h0,fliplr(wc_row_lf));

        % Upsampling
        wc_row_hf = zeros(1, col);
        wc_row_hf(1:2:length(wc_row_hf)) = wc_row(1, col/2+1:col);
        % Inverse Highpass filtering
        wc_row_hf = pconv(g0,fliplr(wc_row_hf));

        % Reconstruct 
        rec_horiz(i,:) = fliplr((wc_row_hf+wc_row_lf));
    end
    
    wc(1:row, 1:col) = rec_horiz;    
end

rec = wc;
