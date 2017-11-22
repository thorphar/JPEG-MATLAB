function output = unmakeZigZag( block_struct,flag )

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

dct2_data = line2square(block_struct);
%UnQuantizedData = applyExtQuant(dct2_data,q_mtx);
UnQuantizedData = dct2_data .* q_mtx;

%% Perform DCT2 to data
Undct2_data = (idct2(UnQuantizedData));


%% shifting data
% norm_data = zeros(8,8);
% for row=1 : 1: 8        
%         for column=1:1:8
%             norm_data(row,column) =int8( Undct2_data(row,column)) -128;
%         end
% end
if flag == 0
    norm_data = double(Undct2_data) + (236+16)/2;
else
    norm_data = double(Undct2_data) + (240+16)/2;
end

output = norm_data;


end

