function [ comp, dict] = HuffEncode( inputArray )
counter = 1;
inputArray(length(inputArray)+1) = 127;
testArray = zeros(length(inputArray),1);
if (inputArray == testArray) 
    symbols(1) = 0;
end
for index=min(inputArray):max(inputArray)
    if nnz(inputArray==index) ~= 0
        symbols(counter) = index;
        counter = counter +  1 ;
    end
end
p = zeros(length(symbols),1);
for index = 1: length(symbols)
    p(index) = nnz(inputArray==symbols(index)) /length(inputArray);
end 
dict = huffmandict(symbols,p);
comp = huffmanenco(inputArray,dict);

end

