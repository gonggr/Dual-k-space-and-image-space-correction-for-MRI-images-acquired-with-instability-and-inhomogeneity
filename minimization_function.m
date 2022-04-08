function [fun]=minimization_function(x,so,background,n)

for j=1:n;
           xj=x(j);
           sk(j,:)=so(j,:)*exp(1i*xj);
end;
       
%        image=abs(ifftshift(ifft2(sk))) ;
       image=abs(ifft2(sk)) ;
       
%        fun=sum(sum(fondo.*imagen));
%        fun=entropia(n,imagen);
       fun = entropy(n,image)+sum(sum(background.*image));

end