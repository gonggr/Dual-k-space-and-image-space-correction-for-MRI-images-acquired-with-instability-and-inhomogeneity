function [c,ceq]= nlcon(x)%%%% condiciones no lineales

ceq = moment(x,1);   %%%% momento de primer orden 
% c= sum(x);
% ceq = sum(x);
% c = sum(x.*2)-mean(x.*2);
c=[];
% ceq=[];
end