function [E]=entropy(n,image)

Bm=sqrt(sum(sum(image.^2)));

   for i=1:n;
       for j=1:n;
           
           A(i,j)=-(image(i,j)/Bm)*log(image(i,j)/Bm);
           
       end;
   end;
       E=sum(sum(A));
end