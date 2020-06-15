function [ output_array ] = square2line( input_array )
index = 1;
output_array = zeros(64,1);
for i = 1:8
    len = i;
    for x = 1 : i
        if mod(i,2) == 0 
            output_array(index) = input_array(x,len);
            index = index + 1;
        else
             output_array(index) = input_array(len,x);
            index = index + 1;
        end
        len = len - 1;
    end
end
counterA = 2;
counterB = 8;
for x = 1:8
    counterC = counterA;
    counterD = counterB;
    for i = 1:(abs(x-8))
        if(x == 1)
            output_array(index) = input_array(counterD,counterC);
            index = index + 1;
        elseif (mod(x,2) == 0)
            output_array(index) = input_array(counterC,counterD);
            index = index + 1;
        else
            output_array(index) = input_array(counterD,counterC);
            index = index + 1;
        end
        counterC = counterC +1;
        counterD = counterD -1;
    end 
    counterA = counterA + 1;
end
end

