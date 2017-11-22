function lecture
object = [0 0 0 0 1 1 1 1 0 0 0 0
          0 0 0 0 1 1 1 1 0 0 0 0
          0 0 0 0 1 1 1 1 0 0 0 0 
          0 0 0 0 1 1 1 1 0 0 0 0
          1 1 1 1 1 1 1 1 1 1 1 1
          1 1 1 1 1 1 1 1 1 1 1 1 
          1 1 1 1 1 1 1 1 1 1 1 1
          1 1 1 1 1 1 1 1 1 1 1 1 
          0 0 0 0 1 1 1 1 0 0 0 0 
          0 0 0 0 1 1 1 1 0 0 0 0 
          0 0 0 0 1 1 1 1 0 0 0 0
          0 0 0 0 1 1 1 1 0 0 0 0];
structure = [1
             1
             1
             1];
object = mat2gray(object, [0 1]);
structure = mat2gray(structure, [0 1]);

imshow(object);
imshow(structure);

[p q]=size(structure);
  [m n]=size(g);
  temp= zeros(m,n);
   for i=1:m
       for j=1:n
           if (g(i,j)==1)
        
             for k=1:p
       for l=1:q
          if(b(k,l)==1)
           c=i+k;
           d=j+l;
           temp(c,d)=1;
          
          end
       end
             end
           end
           
       end
   end
   
   imshow(temp);
end

