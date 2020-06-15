function [ycbcrmap,uncompressed_size,compressed_size,timeElapsed,space_saving_percentage,compressionRatio] = ProcessImage(filename,quant)
%% Reading the image
rgb_image = (imread(['Images/Source/',filename]));
%imshow(rgb_image);
fileInfo = dir(['Images/Source/',filename]);
uncompressed_size = fileInfo.bytes;
tic
%Convert to YCbCr Color Space which will allow us to separate the
%illuminance and chrominance
% Fix image for any size compression
%% Compressing
rgb_image = imresize(rgb_image,[ceil(size(rgb_image,1)/8)*8,ceil(size(rgb_image,2)/8)*8]);
ycbcrmap = rgb2ycbcr(rgb_image);
%Possible down sampling in the chrominance
% Divide the ycbcr map into its parts
illuminance = uint8(ycbcrmap(:,:,1));
CB = uint8(ycbcrmap(:,:,2));
CR = uint8(ycbcrmap(:,:,3));
% get the image size
[image_height image_width] = size(illuminance);
image_width = image_width /8 ;
% Block process the data with 8x8 window. Processing includes, normalizing 
% data, dct2, quantization data, then converts from square2line
processed_illuminance = BlockProcess(illuminance,0,quant);
processed_CB = BlockProcess(CB,1,quant);
processed_CR = BlockProcess(CR,1,quant);
% Huffman encoding on the string
processed_illuminance(length(processed_illuminance)+1) = 127;
processed_CB(length(processed_CB)+1) = 127;
processed_CR(length(processed_CR)+1) = 127;
stream = [processed_illuminance;processed_CB;processed_CR];
[comp, dict] = HuffEncode(stream);
%% Transmit
Saved_Image_width = typecast(uint16(image_width),'int16');

% Get the binary rep into a string 
binRep = [];
for i = 1:1:length(dict(:,2))
    tempHolder = bin2dec(num2str(cell2mat(dict(i,2))));
    binRep = [binRep, tempHolder];
end
binRep = typecast(uint16(binRep), 'int16'); % convert to int16 
% Get the symbol list
symbol_list = cell2mat(dict(:,1));
symbol_list = (double(symbol_list));
symbol_list = transpose(symbol_list);
%% Save as image file format
[token,remain] = strtok(filename,'.');
outputName = ['Images/Com/',token, '.bin'];
Fid = fopen(outputName,'w');
fwrite(Fid,[Saved_Image_width , symbol_list , binRep],'int16');
data_dump = transpose(comp);
data_dump = padarray(data_dump,[0,(16 - mod(length(data_dump), 16))],0,'post'); 
Serial_binary = num2str(reshape(data_dump, 16, []).');  
int16_towrite = typecast(uint16(bin2dec(Serial_binary)),'int16');  % take Serial binary and convert to int16
fwrite(Fid,int16_towrite,'int16');
fclose(Fid);
timeElapsed = toc
fileInfo = dir(outputName);
compressed_size = fileInfo.bytes;
compressionRatio = uncompressed_size/compressed_size
space_saving_percentage = (1-(compressed_size/uncompressed_size))*100
end

