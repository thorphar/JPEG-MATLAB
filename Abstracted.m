function Abstracted
%Read in RGB image
rgb_image = (imread('test.bmp'));
imshow(rgb_image);
%Convert to YCbCr Color Space which will allow us to separate the
%illuminance and chrominance
ycbcrmap = rgb2ycbcr(rgb_image);
%Possible down sampling in the chrominance
% discrete cosine transform
illuminance = int8(ycbcrmap(:,:,1));
CB = int8(ycbcrmap(:,:,2));
CB
CR = int8(ycbcrmap(:,:,3));
%% Normalise data
norm_illuminance = illuminance - 128;
norm_CB = CB - 128;
norm_CR = CR - 128;
%% Perform DCT2 to data
dct2_illuminance = int8(dct2(norm_illuminance));
dct2_CB = int8(dct2(norm_CB));
dct2_CR = int8(dct2(norm_CR));
%% Different quantization matrix
unknownq_mtx = [16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];       
half = [ 16 11 10 16 24 40 51 61;
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56;
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
q_mtx = half./2;

%%Apply quant to data using q_mtx stated above.
QuantizedY = applyEncQuant(dct2_illuminance,q_mtx);
QuantizedCB = applyEncQuant(dct2_CB,q_mtx);
QuantizedCR = applyEncQuant(dct2_CR,q_mtx);

zzQuant = zeros(64,1);
zzQuantCB = zeros(64,1);
zzQuantCR = zeros(64,1);

%% EXTRACT ZIGZAG
zzQuant = square2line(QuantizedY);
zzQuantCB = square2line(QuantizedCB);
zzQuantCR = square2line(QuantizedCR);
%% HUFFMAN ENCODING
[compY, dict] = HuffEncode(zzQuant);
[compCB, dictCB] = HuffEncode(zzQuantCB);
[compCR, dictCR] = HuffEncode(zzQuantCR);
%% Save as image file format
compCB;
size(dict)
size(CB)
%% Transmit

%% Read image file

%% DECODE HUFFMAN 
dsigY = huffmandeco(compY,dict);
dsigCB = huffmandeco(compCB,dictCB);
dsigCR = huffmandeco(compCR,dictCR);
%isequal(sig,dsig) %check if the same
%% FILL IN ZIGZAG
inputY = line2square(dsigY);
inputCB = line2square(dsigCB);
inputCR = line2square(dsigCR);
%% Applying inverse of Quantization
dct2_Y_input = applyExtQuant(inputY,q_mtx);
dct2_CB_input = applyExtQuant(inputCB,q_mtx);
dct2_CR_input = applyExtQuant(inputCR,q_mtx);
%% Regulate data
norm_Y_input = int8(idct2(dct2_Y_input));
Y_input = norm_Y_input + 128;

norm_CB_input = int8(idct2(dct2_CB_input));
CB_input = norm_CB_input + 128;

norm_CR_input = int8(idct2(dct2_CR_input));
CR_input = norm_CR_input + 128;
%% Forming back into a RGB format
input_image(:,:,1) = uint8(Y_input);
input_image(:,:,2) = uint8(CB_input);
input_image(:,:,3) = uint8(CR_input);
input_image_rgb = ycbcr2rgb(input_image);
%% Displaying the image
figure(2);
imshow(input_image_rgb);
imwrite(input_image_rgb,'all.bmp');
end

