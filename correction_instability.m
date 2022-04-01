% ==========================================================================
% function  : correction_instability
% --------------------------------------------------------------------------
% purpose   : correct instability ghosts 
% input     : struct fsn
% output    : struct fsn
% comment   :
% reference :   
% --------------------------------------------------------------------------
% 2022/03 - gonzalo.g.rodriguez@unc.edu.ar 
% ==========================================================================

function [fsn] = correctrion_instability(fsn)

disp('correction_prepare_get_data');

%%% case instability correction %%%
if fsn.param.correction_type == 0; 

    img_initial_1 = fsn.data.img_1{1};  % load degraded image
    s0_1 = fsn.data.s0_1{1};

    %%%%%%%%%% Background definition %%%%%%%%%%%%%%%%%
    T_1 = graythresh(img_initial_1);
    A_1 =imbinarize(img_initial_1,T_1*0.8);
    background_1 =1-A_1;
        
    %%%%%%%%%%% Range of phase correction allowed %%%%%%%%%%%%%%%%
    Max_phase= fsn.param.max_angle;
    Min_phase=- fsn.param.max_angle;
    n = fsn.data.size_y_1;

    %%%%%%% parametros iniciales %%%%%%%%%%%%%%%
%     ordenada=[1:n];
    x=[1:n];
    x0= 0.0*ones(n,1);

    %%%%%%%%%%%%%% funcion a minimizar %%%%%%%%%%%%%

    [fun]=minimization_function(x,s0_1,background_1,n); 

    %%%%%%%%%%%%%% fmincon constrains %%%%%%%%%%%%%
    [c,ceq]= nlcon(x);
    A=[];
    b=[];
    Aeq=ones(n,1)';
    beq=0.0;
    lb=Min_phase*ones(n);
    ub=Max_phase*ones(n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    options = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',fsn.param.max_iteration_1);  
    x_1 = fmincon(@(x)minimization_function(x,s0_1,background_1,n),x0,A,b,Aeq,beq,lb,ub,@(x)nlcon(x),options);
    phase_final_1 = x_1./(2*pi/360);

 
    %%% corrected k-space generation %%%
    for j=1:n
           xj_1=x_1(j);
           sk_1(j,:)=s0_1(j,:)*exp(1i*xj_1);
    end
   
    
    %%% corrected image and phase %%%
    img_corrected_1=abs(ifft2(sk_1)) ;  
    phase_stimated_1= - phase_final_1;
    
    
    %%% saving data in structure %%%
    fsn.data.instability_corrected_1{1} = img_corrected_1;
    fsn.data.phase_stimated_1 = phase_stimated_1;
    
    if fsn.param.display_intermediate_results == 1;
    %%% results plots %%%
    figure
    subplot(1,2,1),imshow(img_initial_1, [] ), title 'initial image'; 
    subplot(1,2,2),imshow(img_corrected_1, [] ), title 'corrected image';
   
    figure
    plot(phase_stimated_1,'color','r');
    end
 
%%% case inhomogeneity correction    
else if fsn.param.correction_type == 1;
        
    fsn.data.instability_corrected_1{1} = fsn.data.img_1{1};
    fsn.data.instability_corrected_2{1} = fsn.data.img_2{1};

%%% case full correction

    else
    img_initial_1 = fsn.data.img_1{1};  % load degraded image
    s0_1 = fsn.data.s0_1{1};

    %%%%%%%%%% Background definition %%%%%%%%%%%%%%%%%
    T_1 = graythresh(img_initial_1);
    A_1 =imbinarize(img_initial_1,T_1*0.8);
    background_1 =1-A_1;
        
    %%%%%%%%%%% Range of phase correction allowed %%%%%%%%%%%%%%%%
    Max_phase= fsn.param.max_angle;
    Min_phase=- fsn.param.max_angle;
    n = fsn.data.size_y_1;

    %%%%%%% initial parameters %%%%%%%%%%%%%%%

    x=[1:n];
    x0= 0.0*ones(n,1);

    %%%%%%%%%%%%%% minimization function %%%%%%%%%%%%%

    [fun]=minimization_function(x,s0_1,background_1,n); 

    %%%%%%%%%%%%%% fmincon constrains %%%%%%%%%%%%%
    [c,ceq]= nlcon(x);
    A=[];
    b=[];
    Aeq=ones(n,1)';
    beq=0.0;
    lb=Min_phase*ones(n);
    ub=Max_phase*ones(n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    options = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',fsn.param.max_iteration_1);  
    x_1 = fmincon(@(x)minimization_function(x,s0_1,background_1,n),x0,A,b,Aeq,beq,lb,ub,@(x)nlcon(x),options);
    phase_final_1 = x_1./(2*pi/360);

 
    %%% corrected k-space generation %%%
    for j=1:n
           xj_1=x_1(j);
           sk_1(j,:)=s0_1(j,:)*exp(1i*xj_1);
    end
   
    
    %%% corrected image and phase %%%
    img_corrected_1=abs(ifft2(sk_1)) ;  
    phase_stimated_1= - phase_final_1;
    
    
    %%% saving data in structure %%%
    fsn.data.instability_corrected_1{1} = img_corrected_1;
    fsn.data.phase_stimated_1 = phase_stimated_1;
    
    if fsn.param.display_intermediate_results == 1;
    %%% results plots %%%
    figure
    subplot(1,2,1),imshow(img_initial_1, [] ), title 'initial image'1; 
    subplot(1,2,2),imshow(img_corrected_1, [] ), title 'corrected image 1';
   
    figure
    plot(phase_stimated_1,'color','r');
    end
    
    %%% load image 2 %%%
    img_initial_2 = fsn.data.img_2{1};  % load degraded image
    s0_2 = fsn.data.s0_2{1};

    %%%%%%%%%% Background definition %%%%%%%%%%%%%%%%%
    T_2 = graythresh(img_initial_2);
    A_2 =imbinarize(img_initial_2,T_2*0.8);
    background_2 =1-A_2;
        
    %%%%%%%%%%% Range of phase correction allowed %%%%%%%%%%%%%%%%
    Max_phase= fsn.param.max_angle;
    Min_phase=- fsn.param.max_angle;
    n = fsn.data.size_y_2;

    %%%%%%% initial parameters %%%%%%%%%%%%%%%

    x=[1:n];
    x0= 0.0*ones(n,1);
    
    %%%%%%%%%%%%%% fmincon constrains %%%%%%%%%%%%%
    [c,ceq]= nlcon(x);
    A=[];
    b=[];
    Aeq=ones(n,1)';
    beq=0.0;
    lb=Min_phase*ones(n);
    ub=Max_phase*ones(n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    %%%%%%%%%%%%%% minimization function %%%%%%%%%%%%%

    [fun]=minimization_function(x,s0_2,background_2,n); 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    options = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',fsn.param.max_iteration_2);  
    x_2 = fmincon(@(x)minimization_function(x,s0_2,background_2,n),x0,A,b,Aeq,beq,lb,ub,@(x)nlcon(x),options);
    phase_final_2 = x_2./(2*pi/360);

 
    %%% corrected k-space generation %%%
    for j=1:n
           xj_2=x_2(j);
           sk_2(j,:)=s0_2(j,:)*exp(1i*xj_2);
    end
   
    
    %%% corrected image and phase %%%
    img_corrected_2=abs(ifft2(sk_2)) ;  
    phase_stimated_2= - phase_final_2;
    
    
    %%% saving data in structure %%%
    fsn.data.instability_corrected_2{1} = img_corrected_2;
    fsn.data.phase_stimated_2 = phase_stimated_2;
    
    if fsn.param.display_intermediate_results == 1;
    %%% results plots %%%
    figure
    subplot(1,2,1),imshow(img_initial_2, [] ), title 'initial image 2'; 
    subplot(1,2,2),imshow(img_corrected_2, [] ), title 'corrected image 2';
   
    figure
    plot(phase_stimated_2,'color','r');
    end
        
   
end
end