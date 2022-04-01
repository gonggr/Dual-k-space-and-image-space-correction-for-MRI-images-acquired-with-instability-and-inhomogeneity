% ==========================================================================
% function  : correction_prepare_get_data
% --------------------------------------------------------------------------
% purpose   : load the data  
% input     : struct fsn
% output    : struct fsn
% comment   :
% reference :   
% --------------------------------------------------------------------------
% 2022/03 - gonzalo.g.rodriguez@unc.edu.ar 
% ==========================================================================

function [fsn] = correction_prepare_get_data(fsn)
    
     disp('correction_prepare_get_data');
        
      if  fsn.param.correction_type == 0; % only instability correction: input 1 image
            % ---- load data
            fsn.data.folder = 'DataTest_Brain\';
            load([fsn.data.folder 'img_instability.mat']); % data name / the image must be complex
            img_1 = img_instability; % matrix name
            [size_y_1,size_x_1] = size(img_1);     
            
            % ---- data normalization
            img_1 = img_1./max(img_1(:));
            
            % ---- k-space
            s0_1 = fft2(img_1);
            
            % ---- save data in structure
            fsn.data.size_x_1 = size_x_1;
            fsn.data.size_y_1 = size_y_1;
            
            fsn.data.img_1{1} = abs(img_1); % save abs value of img_1
            
            fsn.data.s0_1{1} = s0_1;
            
            % display initial image
            figure;
            imshow(fsn.data.img_1{1},[]);% title('data1');
       
      else % inhomogeneity or full correction: input 2 images (G+ & G-)
          
           % ---- load data
           fsn.data.folder = 'DataTest_Brain\'; % Data folder
           load([fsn.data.folder 'img_inhomogeneity_1.mat']); % data 1 name
           load([fsn.data.folder 'img_inhomogeneity_2.mat']); % data 2 name
           img_1 = img_inhomogeneity_1;
           img_2 = img_inhomogeneity_2;
                      
           [size_x_1,size_y_1] = size(img_1);
           [size_x_2,size_y_2] = size(img_2);   
           
            % ---- data normalization
            img_1 = img_1./max(img_1(:));
            img_2 = img_2./max(img_2(:));
            
            % ---- k-space
            s0_1 = fft2(img_1);
            s0_2 = fft2(img_2); 
            
            % ---- save data in structure
            fsn.data.size_x_1 = size_x_1;
            fsn.data.size_y_1 = size_y_1;
            fsn.data.size_x_2 = size_x_2;
            fsn.data.size_y_2 = size_y_2;
            
            fsn.data.img_1{1} = abs(img_1);
            fsn.data.img_2{1} = abs(img_2);
            
            fsn.data.s0_1{1} = s0_1;
            fsn.data.s0_2{1} = s0_2;
            
            if fsn.param.display_intermediate_results == 1;
            % ---- display initial images
            figure;
            subplot(1,2,1); imshow(fsn.data.img_1{1},[]); title('data 1');
            subplot(1,2,2); imshow(fsn.data.img_2{1},[]); title('data 2');
            end
  
      end     
end      









