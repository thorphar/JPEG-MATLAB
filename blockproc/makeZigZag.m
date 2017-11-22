function [output] = makeZigZag( block_struct,flag )
%% shifting data
% norm_data = zeros(length(block_struct),1);
% for row=1 : 1: 8        
%         for column=1:1:8
%             norm_data(row,column) =int8(block_struct(row,column) -128);
%         end
% end

if flag == 0
    norm_data = double(block_struct) - (236+16)/2;
else
    norm_data = double(block_struct) - (240+16)/2;
end

%% Perform DCT2 to data
dct2_data = (dct2(norm_data));
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
q_mtx = half.*2;


%QuantizedData = applyEncQuant(dct2_data,q_mtx);
QuantizedData = round(dct2_data ./ q_mtx);

%% EXTRACT ZIGZAG
zzQuant = square2line(QuantizedData);
output = zzQuant;

end

