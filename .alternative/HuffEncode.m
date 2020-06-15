function [ comp, dict] = HuffEncode( inputArray )
counter = 1;
inputArray(length(inputArray)+1) = 127; %Add end of input character
testArray = zeros(length(inputArray),1); % create holding array
if (inputArray == testArray) 
    symbols(1) = 0;
end
%form list of symbols
for index=min(inputArray):max(inputArray)
    if nnz(inputArray==index) ~= 0
        symbols(counter) = index;
        counter = counter +  1 ;
    end
end
%form list of probabilities
p = zeros(length(symbols),1);
for index = 1: length(symbols)
    p(index) = nnz(inputArray==symbols(index)) /length(inputArray);
end 
dict = huffmandict(symbols,p);
comp = huffmanenco(inputArray,dict);
end

