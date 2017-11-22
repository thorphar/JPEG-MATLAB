function [ output ] = BlockDeProcess( input_args,image_width,flag )
output = zeros((size(input_args,1)/(image_width*8)),(image_width*8));
row_counter = 1;
col_counter = 1;
for index = 1: 1: length(input_args)/64
    temp=unmakeZigZag(input_args((index-1)*64+1:(index)*64),flag);
    output(((row_counter-1)*8+1:(row_counter)*8),((col_counter-1)*8+1:(col_counter)*8)) = temp;
    if col_counter >= image_width
        col_counter = 0;
        row_counter = row_counter + 1;
    end
    col_counter  = col_counter + 1;
end
end

