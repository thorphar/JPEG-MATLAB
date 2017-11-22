function [ processed ] = BlockProcess( input,flag )
processed= [];
[height, width] = size(input);
windowSize = 8;
for row=1 : windowSize: height    
        for column=1:windowSize: width
            working = input([row row+1 row+2 row+3 row+4 row+5 row+6 row+7],...
                [column column+1 column+2 column+3 column+4 column+5 column+6 column+7]);
            [working] = makeZigZag(working,flag);
            processed = [processed; working];
        end
end


end

