function [outFileSize,timeElapsed] = loadImage(filename,quant)
tic
fID = fopen(['Images/Com/', filename],'r');
In_Data = fread(fID,'int16');
fclose(fID);

Image_width = typecast(int16(In_Data(1)),'uint16'); %grab the first line
% the image width is gathered 
In_Data = In_Data(2 : size(In_Data,1)); %now remove the width from the file
% extract the symbols list from the file using the end value of 127
symbols = In_Data(1:find(In_Data == 127));% this works as the list is sorted
% symbols list now needs to be removed from the In_Data list
In_Data = In_Data(size(symbols,1)+1 : size(In_Data,1));%remove symbols
%Now gather the binary rep from the InData 
binRep = dec2bin(typecast(int16(In_Data(1:size(symbols,1))),'uint16'));
%remove the symbols from the list 
In_Data = In_Data(size(symbols,1)+1 : size(In_Data,1));
dict = num2cell(symbols); %convert the number type to cell type

for i = 1:1:size(binRep,1)% loop through to create binreps
    state = num2str(str2num(binRep(i,:))); % create the statment to check
    dict(i,2) = {str2double(regexp(state,'\d','match'))}; %% return matches
end
Check_Statment = reshape((dec2bin(typecast(int16(In_Data),'uint16'))).',...
    [],1).'; %create the statment to check against...
In_Data = str2double(regexp(Check_Statment,'\d','match'));% perform check
%return matches


%% Decompressing
dsig = huffmandeco(In_Data,dict);


%loop through and remove the data in chuncks
dsigY = dsig(1, 1:find(dsig == 127)-1); %Y channel
dsig = dsig(1, find(dsig == 127)+1:size(dsig,2)); 
dsigCB = dsig(1, 1:find(dsig == 127)-1);% CB channel
dsig = dsig(1, find(dsig == 127)+1:size(dsig,2));
dsigCR = dsig(1, 1:find(dsig == 127)-1);% CR channel


% Block De Process takes the data and width then, line2square, applies
% inverse quant, inverse dct2, unnormalize for each 8x8 square
outputY = BlockDeProcess(dsigY,Image_width,0,quant);
outputCB = BlockDeProcess(dsigCB,Image_width,1,quant);
outputCR = BlockDeProcess(dsigCR,Image_width,1,quant);
% put back together
decomImage(:,:,1) = uint8(round(outputY));
decomImage(:,:,2) = uint8(round(outputCB));
decomImage(:,:,3) = uint8(round(outputCR));

rgbOutput = ycbcr2rgb(decomImage);
timeElapsed = toc
[token,remain] = strtok(filename,'.');
imwrite(rgbOutput,['Images/OUTPUT/',token,'_out.png']);

fileInfo = dir(['Images/OUTPUT/',token,'_out.png']);
outFileSize = fileInfo.bytes;


end

