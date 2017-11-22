function [ output ] = applyEncQuant( dct2_input, q_mtx )
for row=1 : 1: 8        
        for column=1:1:8
            output(row,column) = dct2_input(row,column) / q_mtx(row,column);
        end
end

end

