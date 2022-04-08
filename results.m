% ==========================================================================
% function  : results
% --------------------------------------------------------------------------
% purpose   : display de main results 
% input     : struct fsn
% output    : struct fsn
% comment   :
% reference :   
% --------------------------------------------------------------------------
% 2022/03 - gonzalo.g.rodriguez@unc.edu.ar 
% ==========================================================================

function [fsn] = results(fsn)
if fsn.param.correction_type == 0; % only instabiliy

 figure
    subplot(1,2,1); imshow(fsn.data.img_1{1}, []), title 'initial image 1'; 
    subplot(1,2,2); imshow(fsn.data.instability_corrected_1{1}, [] ), title 'instability corrected image 1'; 

 figure
 plot(fsn.data.phase_stimated_1); title 'stimated phase shift';
 
else if fsn.param.correction_type == 1; % only inhomogeneity
 
figure
    subplot(2,3,1); imshow(fsn.data.img_1{1}, []), title 'initial image 1'; 
    subplot(2,3,4); imshow(fsn.data.img_2{1}, []), title 'initial image 2';
    subplot(2,3,3); imshow(fsn.data.img_corrected{1}, [] ), title 'full corrected image';

    
 
    else % full correction
figure
    subplot(2,3,1); imshow(fsn.data.img_1{1}, []), title 'Initial image 1'; 
    subplot(2,3,4); imshow(fsn.data.img_2{1}, []), title 'Initial image 2';
    subplot(2,3,2); imshow(fsn.data.instability_corrected_1{1}, [] ), title 'Instability corrected image 1'; 
    subplot(2,3,5); imshow(fsn.data.instability_corrected_2{1}, [] ), title 'Instability corrected image 2';
    subplot(2,3,3); imshow(fsn.data.img_corrected{1}, [] ), title 'Full corrected image';
    
figure
 plot(fsn.data.phase_stimated_1); title 'Stimated phase shift 1 [degree]';
 figure
 plot(fsn.data.phase_stimated_2); title 'Stimated phase shift 2 [degree]';
 
 figure
 imshow(fsn.data.inhomogeneity{1},[],Colormap=parula); title 'Stimated Be inhomogeneity [au]';
 %%% Be is expressed in adimensional units to obtain the Be in T you should
 %%% multiply by the real spatial resolution and the read gradient intensity 
 
    
end
end
