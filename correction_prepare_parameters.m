% ==========================================================================
% function  : correction_prepare_parameters
% --------------------------------------------------------------------------
% purpose   : configurate the initial parameters  
% input     : struct fsn
% output    : struct fsn
% comment   :
% reference :   
% --------------------------------------------------------------------------
% 2022/03 - gonzalo.g.rodriguez@unc.edu.ar
% ==========================================================================

function [fsn] = correction_prepare_parameters(fsn)

    disp('   prepare fusion - initialize parameters');
  
   % ---- chose correction type
    fsn.param.correction_type = 1;  % [0,1,2]=[only instability, only inhomogeneity, full correction]

    % ---- display results
    fsn.param.display_intermediate_results = 0; %[0,1] 0=no and 1=yes;
   
    % ---- chose max phase angle correction allowed
    fsn.param.max_angle = pi;   % abs value [rad] 

    % ---- max iterationfor fmincom
    fsn.param.max_iteration_1 = 45; % defines max iteration of fmincom for image 1
    fsn.param.max_iteration_2 = 45; % defines max iteration of fmincom for image 2
    
    % ---- define read gradient direction
    fsn.param.read_gradient_direction = 0; %[0,1] 0=x and 1=y;
    
    % ---- resize factor for inhomogeneity correction
    fsn.param.resize_factor = 5; % this factor is used to minimize integral errors in the inhmogeney correction, higher values increase the run time
    
 
end





