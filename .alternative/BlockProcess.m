function [ processed ] = BlockProcess( input,flag,quant)
processed= []; % create mem alloc
[height, width] = size(input); %get height and width of the image 
windowSize = 8; % window size
for row=1 : windowSize: height    
        for column=1:windowSize: width
            working = input([row row+1 row+2 row+3 row+4 row+5 row+6 row+7],...
                [column column+1 column+2 column+3 column+4 column+5 ...
                column+6 column+7]); % create a block to be processed
            [working] = makeZigZag(working,flag,quant);%process data
            processed = [processed; working]; %amend each block of strings
            %TODO: calculate the needed mem alloc for processed...
        end
end
end

