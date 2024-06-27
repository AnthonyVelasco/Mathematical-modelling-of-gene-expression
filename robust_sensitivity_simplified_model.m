function robust_sensitivity_simplified_model
%% Robustness and Sensitivity of Simplified Model
% Calculation of the sensitivity coefficient of the Simplified model 
% to study how the variables my and Y vary with respect to the transcription
% factor X parameter.

% We first start from the equilibrium points of the 6-dimensional model,
% using symbolic computation and, as the equilibrium points of the variables
% my and Y are the same in the simplified model, we use them to calculate 
% the sensitivity coefficient.

disp('Equilibrium points from 6-dimensional Model with all the parameters');
syms Xe n kact kx alpha1 beta1 deltamy deltay gamma1

Xe = Xe
Xne=(Xe.^n)/kact 
Dye=1/(1+(Xe.^n)/kx) 
DyXne=(Xe.^n)/(kx+(Xe.^n)) 
mye=(1/deltamy)*(alpha1+beta1*(Xe.^n)/kx)/(1+(Xe.^n)/kx)
ye=(gamma1/deltay)*(alpha1+beta1*(Xe.^n)/kx)/(1+(Xe.^n)/kx)

% Calculate the sensitivity coefficient in continuous scaled form with the 
% derivative of the steady states with respect to the parameters.

% First the derivative of the steady states with respect to the parameters
% is calculated using the diff function.

derivada_mye_deltamy = diff(mye, deltamy);
derivada_mye_deltay = diff(mye, deltay);
derivada_mye_alpha1 = diff(mye, alpha1);
derivada_mye_beta1 = diff(mye, beta1);
derivada_mye_gamma1 = diff(mye, gamma1);
derivada_mye_kx = diff(mye, kx);
derivada_mye_Xe = diff(mye, Xe);
derivada_mye_n = diff(mye, n);

derivada_ye_deltamy = diff(ye, deltamy);
derivada_ye_deltay = diff(ye, deltay);
derivada_ye_alpha1 = diff(ye, alpha1);
derivada_ye_beta1 = diff(ye, beta1);
derivada_ye_gamma1 = diff(ye, gamma1);
derivada_ye_kx = diff(ye, kx);
derivada_ye_Xe = diff(ye, Xe);
derivada_ye_n = diff(ye, n);

% The sensitivity coefficient is then calculated using the results of the 
% derivative calculations for each of its respective parameters and steady
% states.

coef_sen_mye_deltamy = (deltamy/mye).*derivada_mye_deltamy;
coef_sen_mye_deltay = (deltay/mye).*derivada_mye_deltay;
coef_sen_mye_alpha1 = (alpha1/mye).*derivada_mye_alpha1;
coef_sen_mye_beta1 = (beta1/mye).*derivada_mye_beta1;
coef_sen_mye_gamma1 = (gamma1/mye).*derivada_mye_gamma1;
coef_sen_mye_kx = (kx/mye).*derivada_mye_kx;
coef_sen_mye_Xe = (Xe/mye).*derivada_mye_Xe;
coef_sen_mye_n = (n/mye).*derivada_mye_n;

coef_sen_ye_deltamy = (deltamy/ye).*derivada_ye_deltamy;
coef_sen_ye_deltay = (deltay/ye).*derivada_ye_deltay;
coef_sen_ye_alpha1 = (alpha1/ye).*derivada_ye_alpha1;
coef_sen_ye_beta1 = (beta1/ye).*derivada_ye_beta1;
coef_sen_ye_gamma1 = (gamma1/ye).*derivada_ye_gamma1;
coef_sen_ye_kx = (kx/ye).*derivada_ye_kx;
coef_sen_ye_Xe = (Xe/ye).*derivada_ye_Xe;
coef_sen_ye_n = (n/ye).*derivada_ye_n;


% Show results of the sensitivity coefficients of the steady states from
% the Simplified Model

disp('Sensitivity coefficient of mye with respect to the parameters:');
disp('mye_deltamy');
disp(coef_sen_mye_deltamy);
disp('mye_alpah1');
disp(coef_sen_mye_alpha1);
disp('mye_beta1');
disp(coef_sen_mye_beta1);
disp('mye_gamma1');
disp(coef_sen_mye_gamma1);
disp('mye_kx');
disp(coef_sen_mye_kx);
disp('mye_Xe');
disp(coef_sen_mye_Xe);
disp('mye_n');
disp(coef_sen_mye_n);

disp('Sensitivity coefficient of ye with respect to the parameters:');
disp('ye_deltamy');
disp(coef_sen_ye_deltamy);
disp('ye_deltay');
disp(coef_sen_ye_deltay);
disp('ye_alpha1');
disp(coef_sen_ye_alpha1);
disp('ye_beta1');
disp(coef_sen_ye_beta1);
disp('ye_gamma1');
disp(coef_sen_ye_gamma1);
disp('ye_kx');
disp(coef_sen_ye_kx);
disp('ye_Xe');
disp(coef_sen_ye_Xe);
disp('ye_n');
disp(coef_sen_ye_n);

% Parameters and their corresponding values ​​to replace them

param = [Xe, n, kact, kx, alpha1, beta1, deltamy, deltay, gamma1];
param_valores = [0.2675, 2, 4/50, (4/50)*(0.1/0.1), 0.05, 1.5, 0.01, 0.001, 0.02/0.01];

% Replacing the parameters with values using the subs function and the double
% function has been used to display the results in decimal numbers, in those
% coefficients other than 0 and 1.

coef_sen_mye_alpha1_num = double(subs(coef_sen_mye_alpha1, param, param_valores));
coef_sen_mye_beta1_num = double(subs(coef_sen_mye_beta1, param, param_valores));
coef_sen_mye_kx_num = double(subs(coef_sen_mye_kx, param, param_valores));
coef_sen_mye_Xe_num = double(subs(coef_sen_mye_Xe, param, param_valores));
coef_sen_mye_n_num = double(subs(coef_sen_mye_n, param, param_valores));

disp('Sensitivity coefficient of ye');
disp('mye_deltamy');
disp(coef_sen_mye_deltamy);
disp('mye_deltay');
disp(coef_sen_mye_deltay);
disp('mye_alpha');
disp(coef_sen_mye_alpha1_num);
disp('mye_beta');
disp(coef_sen_mye_beta1_num);
disp('mye_gamma1');
disp(coef_sen_mye_gamma1);
disp('mye_kx');
disp(coef_sen_mye_kx_num);
disp('mye_Xe');
disp(coef_sen_mye_Xe_num);
disp('mye_n');
disp(coef_sen_mye_n_num);

% Replacing the parameters with values using the subs function and the double
% function has been used to display the results in decimal numbers, in those
% coefficients other than 0 and 1.

coef_sen_ye_alpha1_num = double(subs(coef_sen_ye_alpha1, param, param_valores));
coef_sen_ye_beta1_num = double(subs(coef_sen_ye_beta1, param, param_valores));
coef_sen_ye_kx_num = double(subs(coef_sen_ye_kx, param, param_valores));
coef_sen_ye_Xe_num = double(subs(coef_sen_ye_Xe, param, param_valores));
coef_sen_ye_n_num = double(subs(coef_sen_ye_n, param, param_valores));

disp('Sensitivity coefficient of ye');
disp('ye_deltamy');
disp(coef_sen_ye_deltamy);
disp('ye_deltay');
disp(coef_sen_ye_deltay);
disp('ye_alpha');
disp(coef_sen_ye_alpha1_num);
disp('ye_beta');
disp(coef_sen_ye_beta1_num);
disp('ye_gamma1');
disp(coef_sen_ye_gamma1);
disp('ye_kx');
disp(coef_sen_ye_kx_num);
disp('ye_Xe');
disp(coef_sen_ye_Xe_num);
disp('ye_n');
disp(coef_sen_ye_n_num);





