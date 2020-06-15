function [ output ] = BlockDeProcess(input_args,image_width,flag,quant )
output = zeros((size(input_args,1)/(image_width*8)),(image_width*8));
row_counter = 1;
col_counter = 1;
%loop through the cols and rows to allow for placing the 8x8 back into the
%full image
for index = 1: 1: length(input_args)/64
    temp=unmakeZigZag(input_args((index-1)*64+1:(index)*64),flag,quant);
    output(((row_counter-1)*8+1:(row_counter)*8),((col_counter-1)*8+1:(col_counter)*8)) = temp;
    if col_counter >= image_width % hit the end of the width
        col_counter = 0;
        row_counter = row_counter + 1; % increase the row counter ...
    end
    col_counter  = col_counter + 1; %% new col until end of width
end
end

