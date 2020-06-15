function [ output ] = line2square( dsig ) % this method uses the index pos
% loop through the index pos for the top left corner first 
index = 1;
for i = 1:8
    len = i;
    for x = 1 : i
        if mod(i,2) == 0 
            %fprintf('%i',Quantized(x,len))
            output(x,len) = dsig(index);
            index = index + 1;
        else
            %fprintf('%i',Quantized(len,x))
            output(len,x) = dsig(index);
            index = index + 1;
        end
        len = len - 1;
        %fprintf('\n')
    end
end

%loop through the other half...
counterA = 2;
counterB = 8;
for x = 1:8
    counterC = counterA;
    counterD = counterB;
    for i = 1:(abs(x-8))
        if(x == 1)
            %fprintf('%i',Quantized(counterD,counterC))
            output(counterD,counterC) = dsig(index);
            index = index + 1;
        elseif (mod(x,2) == 0)
            %fprintf('%i',Quantized(counterC,counterD))
            output(counterC,counterD) = dsig(index);
            index = index + 1;
        else
            %fprintf('%i',Quantized(counterD,counterC))
            output(counterD,counterC) = dsig(index);
            index = index + 1;
        end
        %fprintf('\n')
        counterC = counterC +1;
        counterD = counterD -1;
    end 
    
    counterA = counterA + 1;
end



end

