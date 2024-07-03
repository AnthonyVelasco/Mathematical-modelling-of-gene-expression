function michaelis_menten_qualitative
%% System of differential equations for autoregulation
% In this system of equations, 3 genes are being modeled, applying the 
% Michaelis-Menten dynamics. The first two equations, which correspond with
% the constant expression model, are:
% y(1) is mx, the messenger RNA of gen x
% y(2) is x, the protein of the gen x
% Equations 3 and 4, which correspond to the positive autoregulation of the
% gene y, are:
% y(3) is my, the messenger RNA of gen y
% y(4) is y, the protein of the gen y
% Equations 5 and 6, which correspond to the negative autoregulation of the
% gene z, are:
% y(5) is mz, the messenger RNA of gen z
% y(6) is z, the protein of the gen z

% Parameters with their respective values
% k11 as the reaction rate of the free promoter 
% k12, k22 and k32 are the degradation rate for mRNA of the genes x, y and
% z respectively.
% k13, k23 and k33 are the reaction constant for the translation of mRNA of
% the genes x, y and z respectively.
% k14, k24 and k34 are the degradation rate for proteins X, Y and Z
% respectively.
% Vm2 and Vm3 are the maximum transcription rate of the genes y and z,
% respectively.
% Km2 is the activation coefficient.
% Km3 is the repression coefficient.

k11=0.05;
k12=0.01;
k13=0.02;
k14=0.001;
Vm2=0.0625;
Km2=25;
k22=0.01;
k23=0.02;
k24=0.001;
Vm3=0.55;
Km3=10;
k32=0.01;
k33=0.02;
k34=0.001;

% We studied each gene separately to study their equilibrium points, the 
% stability of the equilibrium points and their respective sensitivity 
% coefficients separately.

% Constitutive Expression Model

% y(1) is mx, the messenger RNA of gen x
% y(2) is x, the protein of the gen x

h=@(t,y)[k11-k12*y(1);...
    k13*y(1)-k14*y(2)];

% To study the stability of the equilibrium points, symbolic computation 
% has been used to obtain the Jacobian matrix using the Jacobian function 
% and with the eig function the eigenvalues associated to the Jacobian 
% matrix have been obtained.

syms y1 y2 k11 k12 k13 k14 

f1= k11-k12*y1;
f2= k13*y1-k14*y2;

y= [y1,y2];

% Solve the system in steady state
sols = solve([f1,f2], y);

% The Jacobian Matrix is ​​obtained
J = jacobian([f1,f2], y);

% % Replacing the parameters with values using the subs function
J_eq = subs(J, y, [sols.y1, sols.y2]);

% Calculate the eigenvalues ​​of the Jacobian
eigJ_eq = eig(J_eq);

% Calculate the sensitivity coefficient of y1 and y2 in continuous scaled form with the 
% derivative of the steady states with respect to the parameters.

% First the derivative of the steady states with respect to the parameters
% is calculated using the diff function.

derivada_y1_k11 = diff(sols.y1, k11);
derivada_y1_k12 = diff(sols.y1, k12);
derivada_y1_k13 = diff(sols.y1, k13);
derivada_y1_k14 = diff(sols.y1, k14);

derivada_y2_k11 = diff(sols.y2, k11);
derivada_y2_k12 = diff(sols.y2, k12);
derivada_y2_k13 = diff(sols.y2, k13);
derivada_y2_k14 = diff(sols.y2, k14);

% The sensitivity coefficient is then calculated using the results of the 
% derivative calculations for each of its respective parameters and steady
% states.

coef_sen_y1_k11=(k11/sols.y1).*derivada_y1_k11;
coef_sen_y1_k12=(k12/sols.y1).*derivada_y1_k12;
coef_sen_y1_k13=(k13/sols.y1).*derivada_y1_k13;
coef_sen_y1_k14=(k14/sols.y1).*derivada_y1_k14;

coef_sen_y2_k11=(k11/sols.y2).*derivada_y2_k11;
coef_sen_y2_k12=(k12/sols.y2).*derivada_y2_k12;
coef_sen_y2_k13=(k13/sols.y2).*derivada_y2_k13;
coef_sen_y2_k14=(k14/sols.y2).*derivada_y2_k14;

% Show results
disp('Constitutive Expression Model');
disp('Equilibrium points:');
disp(sols);
disp('Equilibrium points with numeric values');
% Replacing the parameters with values using the subs function
param=[k11, k12, k13, k14];
param_valores=[0.05, 0.01, 0.02, 0.001];
pto_eq_const=subs(sols,param,param_valores);
disp(pto_eq_const);
disp('Jacobian Matrix:');
disp(J_eq);
disp('Eigenvalues ​​associated with the Jacobian matrix:');
disp(eigJ_eq);
disp('Sensitivity coefficient of gene x mRNA with respect to k parameters:');
disp('y1_k11');
disp(coef_sen_y1_k11);
disp('y1_k12');
disp(coef_sen_y1_k12);
disp('y1_k13');
disp(coef_sen_y1_k13);
disp('y1_k14');
disp(coef_sen_y1_k14);

disp('Sensitivity coefficient of Protein X with respect to k parameters:');
disp('y2_k11');
disp(coef_sen_y2_k11);
disp('y2_k12');
disp(coef_sen_y2_k12);
disp('y2_k13');
disp(coef_sen_y2_k13);
disp('y2_k14');
disp(coef_sen_y2_k14);

% Positive Autoregulation Model

% y(1) is my, the messenger RNA of gen y
% y(2) is y, the protein of the gen y

i=@(t,y)[(Vm2*y(2)/(Km2+y(2)))-k22*y(1);...
    k23*y(1)-k24*y(2)];

% To study the stability of the equilibrium points, symbolic computation 
% has been used to obtain the Jacobian matrix using the Jacobian function 
% and with the eig function the eigenvalues associated to the Jacobian 
% matrix have been obtained.

syms y1 y2 k22 k23 k24 Vm2 Km2 

f1= (Vm2*y2/(Km2+y2))-k22*y1;
f2= k23*y1-k24*y2;

y= [y1,y2];

% Solve the system in steady state
sols1 = solve([f1,f2], y)

% The Jacobian Matrix is ​​obtained
J = jacobian([f1,f2], y);

% Replacing the parameters with values using the subs function
J_eq_1 = subs(J, y, [sols1.y1(1,1), sols1.y2(1,1)]);
J_eq_2 = subs(J, y, [sols1.y1(2,1), sols1.y2(2,1)]);

% Calculate the eigenvalues ​​of the Jacobian
eigJ_eq_1 = eig(J_eq_1);
eigJ_eq_2 = eig(J_eq_2);


% Calculate the sensitivity coefficient of y1 and y2 in continuous scaled form with the 
% derivative of the steady states with respect to the parameters.

% First the derivative of the steady states with respect to the parameters
% is calculated using the diff function.

derivada_y1_Vm2 = diff(sols1.y1(2,1), Vm2);
derivada_y1_Km2 = diff(sols1.y1(2,1), Km2);
derivada_y1_k32 = diff(sols1.y1(2,1), k22);
derivada_y1_k33 = diff(sols1.y1(2,1), k23);
derivada_y1_k34 = diff(sols1.y1(2,1), k24);

derivada_y2_Vm2 = diff(sols1.y2(2,1), Vm2);
derivada_y2_Km2 = diff(sols1.y2(2,1), Km2);
derivada_y2_k32 = diff(sols1.y2(2,1), k22);
derivada_y2_k33 = diff(sols1.y2(2,1), k23);
derivada_y2_k34 = diff(sols1.y2(2,1), k24);

% The sensitivity coefficient is then calculated using the results of the 
% derivative calculations for each of its respective parameters and steady
% states.

coef_sen_y1_Vm2=(Vm2/sols1.y1(2,1)).*derivada_y1_Vm2;
coef_sen_y1_Km2=(Km2/sols1.y1(2,1)).*derivada_y1_Km2;
coef_sen_y1_k32=(k22/sols1.y1(2,1)).*derivada_y1_k32;
coef_sen_y1_k33=(k23/sols1.y1(2,1)).*derivada_y1_k33;
coef_sen_y1_k24=(k24/sols1.y1(2,1)).*derivada_y1_k34;

coef_sen_y2_Vm2=(Vm2/sols1.y2(2,1)).*derivada_y2_Vm2;
coef_sen_y2_Km2=(Km2/sols1.y2(2,1)).*derivada_y2_Km2;
coef_sen_y2_k32=(k22/sols1.y2(2,1)).*derivada_y2_k32;
coef_sen_y2_k23=(k23/sols1.y2(2,1)).*derivada_y2_k33;
coef_sen_y2_k34=(k24/sols1.y2(2,1)).*derivada_y2_k34;

% Parameters and their corresponding values ​​to replace them

param = [Vm2, Km2, k22, k23, k24];
param_valores = [0.0625, 25, 0.01, 0.02, 0.001];

% Replacing the parameters with values using the subs function and the double
% function has been used to display the results in decimal numbers, in those
% coefficients other than 0 and 1.

coef_sen_y1_Vm2_num = double(subs(coef_sen_y1_Vm2, param, param_valores));
coef_sen_y1_Km2_num = double(subs(coef_sen_y1_Km2, param, param_valores));
coef_sen_y1_k32_num = double(subs(coef_sen_y1_k32, param, param_valores));
coef_sen_y1_k33_num = double(subs(coef_sen_y1_k33, param, param_valores));
coef_sen_y1_k34_num = double(subs(coef_sen_y1_k24, param, param_valores));

coef_sen_y2_Vm2_num = double(subs(coef_sen_y2_Vm2, param, param_valores));
coef_sen_y2_Km2_num = double(subs(coef_sen_y2_Km2, param, param_valores));
coef_sen_y2_k32_num = double(subs(coef_sen_y2_k32, param, param_valores));
coef_sen_y2_k33_num = double(subs(coef_sen_y2_k23, param, param_valores));
coef_sen_y2_k34_num = double(subs(coef_sen_y2_k34, param, param_valores));


% Show results
disp('Positive Autoregulation Model');
disp('Equilibrium points:');
disp(sols1.y1(1,1));
disp(sols1.y2(1,1));
disp(sols1.y1(2,1));
disp(sols1.y2(2,1));
disp('Equilibrium points with numeric values');
pto_eq_y1_1=double(subs(sols1.y1(1,1),param,param_valores));
pto_eq_y2_1=double(subs(sols1.y2(1,1),param,param_valores));
pto_eq_y1_2=double(subs(sols1.y1(2,1),param,param_valores));
pto_eq_y2_2=double(subs(sols1.y2(2,1),param,param_valores));
disp(pto_eq_y1_1);
disp(pto_eq_y2_1);
disp(pto_eq_y1_2);
disp(pto_eq_y2_2);
disp('Jacobian Matrix:');
disp(J_eq_1);
disp(J_eq_2);
disp('Eigenvalues ​​associated with the Jacobian matrix for equilibrium point (0,0):');
disp(eigJ_eq_1);
autovalores_1=double(subs(eigJ_eq_1, param, param_valores));
disp(autovalores_1);
disp('Eigenvalues ​​associated with the Jacobian matrix for equilibrium point (5,100):');
disp(eigJ_eq_2);
autovalores_2=double(subs(eigJ_eq_2, param, param_valores));
disp(autovalores_2);
disp('Sensitivity coefficient of gene y mRNA with respect to k parameters:');
disp('y1_Vm2');
disp(coef_sen_y1_Vm2_num);
disp('y1_Km2');
disp(coef_sen_y1_Km2_num);
disp('y1_k22');
disp(coef_sen_y1_k32_num);
disp('y1_k23');
disp(coef_sen_y1_k33_num);
disp('y1_k24');
disp(coef_sen_y1_k34_num);

disp('Sensitivity coefficient of Protein Y with respect to k parameters:');
disp('y2_Vm2');
disp(coef_sen_y2_Vm2_num);
disp('y2_Km2');
disp(coef_sen_y2_Km2_num);
disp('y2_k22');
disp(coef_sen_y2_k32_num);
disp('y2_k23');
disp(coef_sen_y2_k33_num);
disp('y2_k24');
disp(coef_sen_y2_k34_num);

% Negative Autoregulation Model

% y(1) is mz, the messenger RNA of gen z
% y(2) is z, the protein of the gen z

j=@(t,y)[(Vm3/(1+(y(2)/Km3)))-k32*y(1);...
    k33*y(1)-k34*y(2)];

% To study the stability of the equilibrium points, symbolic computation 
% has been used to obtain the Jacobian matrix using the Jacobian function 
% and with the eig function the eigenvalues associated to the Jacobian 
% matrix have been obtained.

syms y1 y2 k32 k33 k34 Vm3 Km3 

f1= (Vm3/(1+(y2/Km3)))-k32*y1;
f2= k33*y1-k34*y2;

y= [y1,y2];

% Solve the system in steady state
sols2 = solve([f1,f2], y);
param = [Vm3, Km3, k32, k33, k34];
param_valores = [0.55, 10, 0.01, 0.02, 0.001];
valor=subs(sols2, param, param_valores);

% Since negative equilibria are meaningless in nature, we discard negative
% equilibria and stick with positive equilibria.

% The Jacobian Matrix is obtained
J = jacobian([f1,f2], y);

% Replacing the parameters with values using the subs function
J_eq_1 = subs(J, y, [sols2.y1(2,1), sols2.y2(2,1)]);

% Calculate the eigenvalues ​​of the Jacobian
eigJ_eq_1 = eig(J_eq_1);

% Calculate the sensitivity coefficient of y1 and y2 in continuous scaled form with the 
% derivative of the steady states with respect to the parameters.

% First the derivative of the steady states with respect to the parameters
% is calculated using the diff function.

derivada_y1_Vm3 = diff(sols2.y1(2,1), Vm3);
derivada_y1_Km3 = diff(sols2.y1(2,1), Km3);
derivada_y1_k32 = diff(sols2.y1(2,1), k32);
derivada_y1_k33 = diff(sols2.y1(2,1), k33);
derivada_y1_k34 = diff(sols2.y1(2,1), k34);

derivada_y2_Vm3 = diff(sols2.y2(2,1), Vm3);
derivada_y2_Km3 = diff(sols2.y2(2,1), Km3);
derivada_y2_k32 = diff(sols2.y2(2,1), k32);
derivada_y2_k33 = diff(sols2.y2(2,1), k33);
derivada_y2_k34 = diff(sols2.y2(2,1), k34);

% The sensitivity coefficient is then calculated using the results of the 
% derivative calculations for each of its respective parameters and steady
% states.

coef_sen_y1_Vm3=(Vm3/sols2.y1(2,1)).*derivada_y1_Vm3;
coef_sen_y1_Km3=(Km3/sols2.y1(2,1)).*derivada_y1_Km3;
coef_sen_y1_k32=(k32/sols2.y1(2,1)).*derivada_y1_k32;
coef_sen_y1_k33=(k33/sols2.y1(2,1)).*derivada_y1_k33;
coef_sen_y1_k34=(k34/sols2.y1(2,1)).*derivada_y1_k34;

coef_sen_y2_Vm3=(Vm3/sols2.y2(2,1)).*derivada_y2_Vm3;
coef_sen_y2_Km3=(Km3/sols2.y2(2,1)).*derivada_y2_Km3;
coef_sen_y2_k32=(k32/sols2.y2(2,1)).*derivada_y2_k32;
coef_sen_y2_k33=(k33/sols2.y2(2,1)).*derivada_y2_k33;
coef_sen_y2_k34=(k34/sols2.y2(2,1)).*derivada_y2_k34;

% Parameters and their corresponding values ​​to replace them

param = [Vm3, Km3, k32, k33, k34];
param_valores = [0.55, 10, 0.01, 0.02, 0.001];

% Replacing the parameters with values using the subs function and the double
% function has been used to display the results in decimal numbers, in those
% coefficients other than 0 and 1.

coef_sen_y1_Vm3_num = double(subs(coef_sen_y1_Vm3, param, param_valores));
coef_sen_y1_Km3_num = double(subs(coef_sen_y1_Km3, param, param_valores));
coef_sen_y1_k32_num = double(subs(coef_sen_y1_k32, param, param_valores));
coef_sen_y1_k33_num = double(subs(coef_sen_y1_k33, param, param_valores));
coef_sen_y1_k34_num = double(subs(coef_sen_y1_k34, param, param_valores));

coef_sen_y2_Vm3_num = double(subs(coef_sen_y2_Vm3, param, param_valores));
coef_sen_y2_Km3_num = double(subs(coef_sen_y2_Km3, param, param_valores));
coef_sen_y2_k32_num = double(subs(coef_sen_y2_k32, param, param_valores));
coef_sen_y2_k33_num = double(subs(coef_sen_y2_k33, param, param_valores));
coef_sen_y2_k34_num = double(subs(coef_sen_y2_k34, param, param_valores));


% Show results
disp('Negative Autoregulation Model');
disp('Equilibrium points:');
disp(valor.y1(1,1));
disp(valor.y2(1,1));
disp(valor.y1(2,1));
disp(valor.y2(2,1));
disp(['As a negative equilibrium does not make sense in nature, we discard it.'])
disp('Jacobian Matrix:');
disp(J_eq_1);
disp('Eigenvalues ​​associated with the Jacobian matrix:');
disp(J_eq_1);
autovalores=double(subs(eigJ_eq_1, param, param_valores));
disp(autovalores);
disp('Sensitivity coefficient of gene z mRNA with respect to k parameters:');
disp('y1_Vm3');
disp(coef_sen_y1_Vm3_num);
disp('y1_Km3');
disp(coef_sen_y1_Km3_num);
disp('y1_k32');
disp(coef_sen_y1_k32_num);
disp('y1_k33');
disp(coef_sen_y1_k33_num);
disp('y1_k34');
disp(coef_sen_y1_k34_num);

disp('Sensitivity coefficient of Protein Z with respect to k parameters:');
disp('y2_Vm3');
disp(coef_sen_y2_Vm3_num);
disp('y2_Km3');
disp(coef_sen_y2_Km3_num);
disp('y2_k32');
disp(coef_sen_y2_k32_num);
disp('y2_k33');
disp(coef_sen_y2_k33_num);
disp('y2_k34');
disp(coef_sen_y2_k34_num);

% System of differential equations with the constitutive expression,
% positive autoregulation and negative autoregulation.

% The ode45 function is utilized to solve the system, and the deval function
% to evaluate the solution obtained by ode45 at specific points in time.

% Parameters
k11=0.05;
k12=0.01;
k13=0.02;
k14=0.001;
Vm2=0.0625;
Km2=25;
k22=0.01;
k23=0.02;
k24=0.001;
Vm3=0.55;
Km3=10;
k32=0.01;
k33=0.02;
k34=0.001;

% Sistema de ecuaciones diferenciales
h=@(t,y)[k11-k12*y(1);...
    k13*y(1)-k14*y(2);...
    (Vm2*y(4)/(Km2+y(4)))-k22*y(3);...
    k23*y(3)-k24*y(4);...
    (Vm3/(1+(y(6)/Km3)))-k32*y(5);...
    k33*y(5)-k34*y(6)];

% Starting values
y0= [1,1,1,1,1,1];

sol=ode45(h,[0,8000],y0);
mx=@(t)deval(sol,t,1);
x=@(t)deval(sol,t,2);
my=@(t)deval(sol,t,3);
y=@(t)deval(sol,t,4);
mz=@(t)deval(sol,t,5);
z=@(t)deval(sol,t,6);

% As we have already calculated the stationary points for each of the models,
% we know that the equilibrium points of the three proteins is 100. As the 
% response time is the time it takes to reach half of the concentrations at 
% equilibrium, which in this case is 50, we use the deval function to 
% construct a function that will allow us to obtain the response time of 
% each of the proteins with the fzero function.

xe=@(t)deval(sol,t,2)-50;
res_time_x= fzero(xe,759);
ye=@(t)deval(sol,t,4)-50;
res_time_y= fzero(ye,1948);
ze=@(t)deval(sol,t,6)-50;
res_time_z= fzero(ze,185);

% Figure for graph Proteins X, Y, Z and their response time.
hold on
figure(1);
t=linspace(0,8000);
plot(t, x(t),'r');
plot(res_time_x, 50,'ro', 'MarkerFaceColor', 'r');
plot(t, y(t),'b');
plot(res_time_y, 50,'ro', 'MarkerFaceColor', 'r');
plot(t, z(t),'g');
plot(res_time_z, 50,'ro', 'MarkerFaceColor', 'r');
yline(50,'--')
xlabel('Time (s)');
ylabel('Protein concentration X, Y, Z');
legend('Protein X Constitutive Expression','Protein X response time (766.86s)', ...
    'Protein Y Positive Autoregulation','Protein Y response time (1944.60s)', ...
    'Protein Z Negative Autoregulation', 'Protein Z response time (185.37s)', ...
    'Location','best');
hold off





