function full_and_constitutive_expression
%% 6-dimensional Model for X=0 and Constitutive Expression Model
% 6-dimensional Model
% y(1) is X, the transcription factor
% y(2) is Xn, the active form of the transcription factor
% y(3) is Dy, the free promoter of gen y
% y(4) is DyXn, the occupied promoter of gen y
% y(5) is my, the messenger RNA of gen y
% y(6) is y, the protein of the gen y

% Parameters with their respective values
% n is the number of subunits making up the active complex Xn
% ka is the association constant
% kd is the dissociation constant
% kon is the binding constant
% koff is the unbinding constant
% alpha and beta as the reaction rate of the free promoter and the occupied
% promoter, respectively.
% deltamy is the degradation rate for mRNA
% deltay is the degradation rate for protein Y
% sy is the reaction constant for the translation of mRNA

n=2;
ka=50;
kd=4;
kon=0.1;
koff=0.1;
alpha=0.05;
beta=1.5;
deltamy=0.01;
deltay=0.001;
sy=0.02;

% 6-dimensional Model
f=@(t,y)[n*kd*y(2)-2*50*y(1).^n;...
    ka*y(1).^n+koff*y(4)-kd*y(2)-kon*y(3)*y(2);...
    koff*y(4)-kon*y(3)*y(2);...
    kon*y(3)*y(2)-koff*y(4);...
    alpha*y(3)+beta*y(4)-deltamy*y(5);...
    sy*y(5)-deltay*y(6)];

% Starting values
y0 = [0, 0, 1, 0, 0, 0];

% The ode45 function is utilized to solve the model, and the deval function
% to evaluate the solution obtained by ode45 at specific points in time.

solution=ode45(f,[0,9000],y0);
x=@(t)deval(solution,t,1);
xn=@(t)deval(solution,t,2);
dy=@(t)deval(solution,t,3);
dyxn=@(t)deval(solution,t,4);
my=@(t)deval(solution,t,5);
y=@(t)deval(solution,t,6);

% Figure for graph X and Xn
figure(1)
hold on
axis([0 0.6 -1 1]);
t=linspace(0,1);
plot(t, x(t), 'r');
plot(t, xn(t), 'b');
plot(0, x(0), 'go', 'MarkerFaceColor', 'g');
plot(0, xn(0), 'go', 'MarkerFaceColor', 'g');
yline(x(0.6),'--');
yline(xn(0.6),'--');
title('Transcription factor (X) and Active Transcription factor (Xn)');
xlabel('Time (s)');
ylabel('X Concentration, Xn Concentration');
legend('X', 'Xn', 'Initial Data','Location','best');
hold off
shg


% Figure for graph Dy and DyXn
figure(2)
hold on
axis([0 60 -1 2]);
t=linspace(0,60);
plot(t, dy(t), 'r');
plot(t, dyxn(t), 'b');
plot(0, dy(0), 'go', 'MarkerFaceColor', 'g');
plot(0, dyxn(0), 'go', 'MarkerFaceColor', 'g');
yline(dy(60),'--');
yline(dyxn(60),'--');
title('Free promoter (Dy) and Occupied promoter (DyXn)');
xlabel('Time (s)');
ylabel('Dy Concentration and DyXn Concentration');
legend('Dy', 'DyXn', 'Initial Data','Location','best');
hold off
shg

% Figure for graph my and Y
figure(3)
hold on
t=linspace(0,9000);
plot(t, my(t), 'r');
plot(t, y(t), 'b');
plot(0, my(0), 'go', 'MarkerFaceColor', 'g');
plot(0, y(0), 'go', 'MarkerFaceColor', 'g');
yline(my(9000),'--');
yline(y(9000),'--');
title('mRNA (my) and Protein (Y) Complete Model for X=0');
xlabel('Time (s)');
ylabel('my Concentration, Y Concentration');
legend('my', 'Y', 'Initial Data','Location','best');
hold off
shg

%% Constitutive expression of the gene y.
% The simplified model obtained by taking X = 0, which is known as the 
% constitutive expression of a gene, is then studied and the system is 
% reduced to:
% y(1) is my, the messenger RNA of gen y
% y(2) is y, the protein of the gen y

% Parameters with their respective values
% alpha as the reaction rate of the free promoter 
% deltamy is the degradation rate for mRNA
% deltay is the degradation rate for protein Y
% sy is the reaction constant for the translation of mRNA

k1=alpha;
k2=deltamy;
k3=sy;
k4=deltay;

% Constitutive Expression Model
h=@(t,y)[k1-k2*y(1);...
    k3*y(1)-k4*y(2)];

% Starting values
y0=[0,0];

% The ode45 function is utilized to solve the model, and the deval function
% to evaluate the solution obtained by ode45 at specific points in time.

sol2=ode45(h,[0,9000],y0);
t=linspace(0,9000);
my=@(t)deval(sol2,t,1);
y=@(t)deval(sol2,t,2);

% Figure for graph my and Y from Constitutive Expression Model
figure(4)
hold on
plot(t, my(t),'r')
plot(t, y(t), 'b')
plot(0, my(0), 'go', 'MarkerFaceColor', 'g');
yline(100,'--');
yline(5,'--');
title('mRNA (my) and Protein (Y) Constitutive Expression Model');
xlabel('Time (s)');
ylabel('my Concentration, Y Concentration');
legend('my', 'Y', 'Initial Data','Location','best');
hold off

%% Equilibrium points and Stability study of the complete model for X=0.
% Applying the quasi-steady-state approximation, the equations are equated 
% to zero and the equilibrium points from 6-dimensional model are obtained.

% Parameters with their respective values
% n is the number of subunits making up the active complex Xn
% ka is the association constant
% kd is the dissociation constant
% kon is the binding constant
% koff is the unbinding constant
% alpha and beta as the reaction rate of the free promoter and the occupied
% promoter, respectively.
% deltamy is the degradation rate for mRNA
% deltay is the degradation rate for protein Y
% sy is the reaction constant for the translation of mRNA
% kact is the equilibrium constant of the transcriptional factor 
% activation/deactivation reactions.
% ku is the equilibrium constant of promoter binding/unbinding given by 
% the reactions.
% kx encompass the above two equilibrium constants kact and ku.
% gamma is sy/deltamy

kact=kd/ka;
ku=koff/kon;
kx=kact*ku;
gamma=sy/deltamy;

% The deval function takes the last value of the variable x, which is the
% equilibrium point.

x=@(t)deval(solution,150,1);

disp('Equilibrium point of X');
disp([x(t)]);

% Applying the quasi-steady state approximation, the equations are equated 
% to zero and the equilibrium points are obtained.

disp('Equilibrium points of the 6-dimensional Model for X=0');
Xe=0
Xne=0
Dye=1
DyXne=0
mye=alpha/deltamy
ye=(gamma*alpha)/deltay

% To study the stability of the equilibrium points, symbolic computation 
% has been used to obtain the Jacobian matrix using the Jacobian function 
% and with the eig function the eigenvalues associated to the Jacobian 
% matrix have been obtained.

syms y1 y2 y3 y4 y5 y6 

f1= n*kd*y2-2*50*y1.^n;
f2= ka*y1.^n+koff*y4-kd*y2-kon*y3*y2;
f3= koff*y4-kon*y3*y2;
f4= kon*y3*y2-koff*y4;
f5= alpha*y3+beta*y4-deltamy*y5;
f6= sy*y5-deltay*y6;

% Variables of the model
y=[y1,y2,y3,y4,y5,y6];

disp('Jacobian matrix of 6-dimensional Model for X=0');
J=jacobian([f1,f2,f3,f4,f5,f6],y)
disp('Eigenvalues associated to the Jacobian matrix ')
eigJ = eig(J)
disp('Values of the eigenvalues associated to the Jacobian matrix of 6-dimensional Model for X=0');
% Replacing the parameters with values using the subs function and the double
% function has been used to display the results in decimal numbers.
double(subs(eigJ,y,[Xe,Xne,Dye,DyXne,mye,ye]))

% Symbolic computation has been applied to study the stability of the 
% equilibrium points (mye and ye) of the Constitutive Expression Model.

syms y1 y2

f1= k1-k2*y1;
f2= k3*y1-k4*y2;

% Variables of the model (my and Y)
y= [y1,y2];

% The solve function is used to solve the system
disp('Equilibrium points of Constitutive Expression Model');
% The solve function solves the system allowing to obtain the equilibrium points.
sols = solve([f1,f2], y);
disp(sols);

% Substitute the solutions in the Jacobian to obtain the Jacobian at equilibrium.
disp('Jacobian matrix of Constitutive Expression Model');
J = jacobian([f1,f2], y)

% Calculate the Jacobian at the point of equilibrium.
% Replacing the parameters with values using the subs function and the double
% function has been used to display the results in decimal numbers.
J_eq = double(subs(J, y, [sols.y1, sols.y2]));

% Calculate the eigenvalues of the Jacobian
disp('Values of the eigenvalues associated to the Jacobian matrix of Constitutive Expression Model');
eigJ_eq = eig(J_eq)





