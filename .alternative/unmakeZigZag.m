function output = unmakeZigZag( block_struct,flag,quant)
%% quantization matrix     
half_Y = [ 16 11 10 16 24 40 51 61;
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56;
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
half_Chrome = [17 18 24 47 99 99 99 99;
               18 21 26 66 99 99 99 99;
               24 26 56 99 99 99 99 99;
               47 66 99 99 99 99 99 99;
               99 99 99 99 99 99 99 99;
               99 99 99 99 99 99 99 99;
               99 99 99 99 99 99 99 99;
               99 99 99 99 99 99 99 99];
           
dct2_data = line2square(block_struct);

if flag == 0 %y
    q_mtx = half_Y.*quant;  
    UnQuantizedData = dct2_data .* q_mtx;
    Undct2_data = (idct2(UnQuantizedData));
    norm_data = double(Undct2_data) + (236+16)/2;
else % Cb Cr
    q_mtx = half_Chrome.*quant;  
    UnQuantizedData = dct2_data .* q_mtx;
    Undct2_data = (idct2(UnQuantizedData));
    norm_data = double(Undct2_data) + (240+16)/2;
end

output = norm_data;


end

