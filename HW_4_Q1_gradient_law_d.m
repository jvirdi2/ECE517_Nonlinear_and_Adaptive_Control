% Q1-Gradient Law simulations for part d
% u=sin(t)

% Get y and u as function of t first by simulating the given system
m=20;
beta=0.1;
k=5;
A=[[0 1];[-k/m -beta/m]];
B=[0;1/m];
tf=200;%200
dt=0.00002;
y=zeros(2,tf/dt+1); % initial condition assumed as [0;0]

for index=1:((tf/dt))
    t=(index-1)*dt;
    u=10*sin(2*t); % Here specify the control input
    y(:,index+1)=y(:,index)+dt*(A*y(:,index)+B*u);
end

% Here the real simulation starts for estimating parameters
% given y and u only
given_output=[1 0]*y;
% Here, the initial value of ydot and yddot is assumed randomly as 1 and 2
% Used backward difference method to compute displacement derivative values
% at remaining time instants etc
y_actual_dot=[1,(given_output(2:end)-given_output(1:end-1))/dt];
y_actual_ddot=[2,(y_actual_dot(2:end)-y_actual_dot(1:end-1))/dt];
gamma=[1 0 0;0 2 0;0 0 3];
initial_parameter_estimate=zeros(3,tf/dt+1);

for index=1:((tf/dt))
    t=(index-1)*dt;
    u=10*sin(2*t); % Here specify the control input
    y_actual=given_output(index);
    y_dot=y_actual_dot(index);
    phi=[u;-y_dot;-y_actual];
    y_estim=(initial_parameter_estimate(:,index)'*phi);
    error=(y_estim-y_actual_ddot(index));
    initial_parameter_estimate(:,index+1)=initial_parameter_estimate(:,index)...
    +dt*(-1)*(gamma*phi*error);
end
 
