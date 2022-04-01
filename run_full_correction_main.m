% ==========================================================================
% script    : run_full_correction_main
% --------------------------------------------------------------------------
% purpose   : correct artifacts due to magnetic field instability and inhomogeneity   
% input     : two complex MRI images acquired with inverted read gradient
% output    : corrected image, intermediate corrected images, phase correction and estimated magnetic field inhomogeneity 
% comment   :
% reference : Rodriguez GG et al. MRI, 87 (2022) 157–168, https://doi.org/10.1016/j.mri.2022.01.008    
% --------------------------------------------------------------------------
% 2022/03 - gonzalo.g.rodriguez@unc.edu.ar
% ==========================================================================


%% - 1 - initialization

clear; clc; close all; 
disp(' '); disp(' run_full_correction_main'); 
fsn = struct;
t1 = tic;


%% - 1 -  preparation 
[fsn] = correction_prepare_parameters(fsn);

%% - 2 -  Get data 
[fsn] = correction_prepare_get_data(fsn);


%% - 3 - instability correction
[fsn] = correction_instability(fsn);

%% - 4 - inhomogeneity correction
[fsn] = correction_inhomogeneity(fsn);

%% - 5 - results

[fsn] = results(fsn); 


%% - 11 - the end

disp(['   time [s] = ' num2str(toc(t1))]); clear t1;
disp('   done!');


%%













