function [ output_DCT2_input ] = applyExtQuant( input, q_mtx )
for row=1 : 1: 8        
        for column=1:1:8
            output_DCT2_input(row,column) = input(row,column) * q_mtx(row,column);
        end
end
end

