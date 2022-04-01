% ==========================================================================
% function  : correction_inhomogeneity
% --------------------------------------------------------------------------
% purpose   : correct inhomogeneity distortions 
% input     : struct fsn
% output    : struct fsn
% comment   :
% reference :   
% --------------------------------------------------------------------------
% 2022/03 - gonzalo.g.rodriguez@unc.edu.ar 
% ==========================================================================

function [fsn] = correctrion_inhomogeneity(fsn)

if fsn.param.correction_type == 1|2;

%%% load images
    img_distorted_1 = fsn.data.instability_corrected_1{1};
    img_distorted_2 = fsn.data.instability_corrected_2{1};

    
    if fsn.param.read_gradient_direction == 0; % x
%%% Increase resolution in read gradient direction
      img_distorted_1=imresize(img_distorted_1,[fsn.data.size_y_1,fsn.param.resize_factor*fsn.data.size_x_1],'bilinear');
      img_distorted_2=imresize(img_distorted_2,[fsn.data.size_y_2,fsn.param.resize_factor*fsn.data.size_x_2],'bilinear');
    else 
        %%% Increase resolution in read gradient direction
      img_distorted_1=imresize(img_distorted_1,[fsn.param.resize_factor*fsn.data.size_x_1,fsn.data.size_y_1],'bilinear');
      img_distorted_2=imresize(img_distorted_2,[fsn.param.resize_factor*fsn.data.size_x_1,fsn.data.size_y_1],'bilinear');
    end
      
      %%% Edge detection
      
      %%% normalization
      
      img_distorted_1 = img_distorted_1/max(max(img_distorted_1));
      img_distorted_2 = img_distorted_2/max(max(img_distorted_2));
      T1 = graythresh(img_distorted_1);
      T2 = graythresh(img_distorted_2);
      A1=imbinarize(img_distorted_1,T1);
      A2=imbinarize(img_distorted_2,T2);
      [M,N]=size(img_distorted_1);

for i=1:M;
    for j=1:N ;
              I1(i,j)=img_distorted_1(i,j)*A1(i,j);
              I2(i,j)=img_distorted_2(i,j)*A2(i,j);
    end;
end;

 %%% Row normalizacion   
   [M,N]=size(I1);
   suma1_fila=trapz(I1'); 
   suma2_fila=trapz(I2');
            for i=1:M ;
                   I1(i,:)=I1(i,:)/(suma1_fila(i)+eps); 
                   I2(i,:)=I2(i,:)/(suma2_fila(i)+eps);     
            end;
     
           
%%%% Integration along read direction
   for i=1:M;
       for j=1:N;
     v1=I1(i,1:j)  ;
     v2=I2(i,1:j)  ;
        INTEGRAL_1(i,j)=trapz(v1);
        INTEGRAL_2(i,j)=trapz(v2);  
       end;
   end;
   
%%% Bijection between img_distorted_1 and img_distorted_2
   X1=[];
   X2=[];
   Y=[];
  pasos=10; % integration steps

  
   for i=1:M;
        c1=I1(i,:);
        c2=I2(i,:);
           if ((max(c1)<=10*eps ||max(c2)<=10*eps));
             continue;
           end;
  INT_1=INTEGRAL_1(i,:);
  INT_2=INTEGRAL_2(i,:);
 
 jmin=min(find(INT_1>0));
 jmax=max(find(c1>0));
   
 Xn1=[jmin];
 Xn2=[min(find(INT_2>0))];
 Yn=[i];
 c1m=0.1*max(c1(:));
 
 
         for j=jmin+pasos:pasos:jmax;
                 
              INT1=INT_1(j);
                x2= find(INT_2<=INT1); 
                x2=max(x2);            
                delta2=x2-max(Xn2);
                delta1=j-max(Xn1);
                r=delta1/delta2;
                l=20;         %%%% Jacobian limit
                     
          if ((length(x2)>0)& (r<l | r<1/l)& (c1(j)>c1m));    
                     
                 Xn1=[Xn1,j];
                 Xn2=[Xn2,x2];
                 equisn1=[Xn1,j];   
                 equisn2=[Xn2,x2];   
                 r ;
          else;
                   
                 continue;
          end;
                  
                 z=length(Xn1);
                 Yn=ones(1,z)*i;
                 
                X1=[X1,Xn1];   
                X2=[X2,Xn2];   
                 Y=[Y,Yn];      
                
                 
                 equisn2(i,:)= equisn2; %%% cambio vectores por matrices
%                  ye(i,:)= Yn;
         end;
             
             
   end;
   
   size(X1);
   size(X2);
  X=round((X1+X2)*0.5);
  
  jmin=min(X);
  jmax=max(X);
  imin=min(Y);
  imax=max(Y);
 
  img_distorted_1=imresize(img_distorted_1,[M,N]); 
  img_distorted_2=imresize(img_distorted_2,[M,N]); 
  [M,N]=size(img_distorted_1);
  
%%%% Fit
    f1 = fit([X',Y'], X1','poly55');
    f2 = fit([X',Y'], X2','poly55');
  for i=1:M;
      for j=1:N;
           x=j;
           y=i;
           x1=round(f1(x,y));
           x2=round(f2(x,y));
           if (x1<1||x1>N||x2<1||x2>N||j<jmin||j>jmax||i<imin||i>imax);
           corrected_image(i,j)=0;
           Be(i,j)=0;
           continue;
           else ;
           corrected_image(i,j)=2*img_distorted_1(i,x1)*img_distorted_2(i,x2)/((img_distorted_1(i,x1)+img_distorted_2(i,x2)));
           Be(i,j)=0.5*(x1-x2);
        end  ;
     end    ;
  end;
    
  
%%% Resizing to original size
    corrected_image=imresize(corrected_image,[fsn.data.size_y_1,fsn.data.size_x_1 ]);
    img_distorted_1=imresize(img_distorted_1,[fsn.data.size_y_1,fsn.data.size_x_1]);
    img_distorted_2=imresize(img_distorted_2,[fsn.data.size_y_2,fsn.data.size_x_2]);
    Be=imresize(Be,[fsn.data.size_y_1,fsn.data.size_x_1]); %round(128/c)
    T_be =  graythresh(corrected_image);
    mask_be = imbinarize(corrected_image,T_be*0.5);
    Be = Be.*mask_be;
      
if fsn.param.display_intermediate_results == 1;
%%%% Result plots

figure
subplot(1,3,1),imshow(img_distorted_1, []), title 'image 1' ;
subplot(1,3,2),imshow(img_distorted_2, []), title 'image 2';
subplot(1,3,3),imshow(corrected_image,[]), title 'image corrected';

figure
imshow(Be,[]), title 'Stimated inhomogeneity [au]';
end

%%% saving data

fsn.data.img_corrected{1} = corrected_image;
fsn.data.inhomogeneity{1} = Be;

end
end